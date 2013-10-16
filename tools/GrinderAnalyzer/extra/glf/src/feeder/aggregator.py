
# Copyright (C) 2011-2012, Travis Bear
# All rights reserved.
#
# This file is part of Graphite Log Feeder.
#
# Graphite Log Feeder is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Graphite Log Feeder is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Graphite Log Feeder; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

import socket
import settings
import sys

HOSTNAME = socket.gethostname().split('.')[0]
GRAPHITE_PREFIX = "%s.%s.log" % (settings.carbon_prefix, HOSTNAME)

class GraphiteAggregator:
    
    def __init__(self, start_timestamp):
        print "Initialized Graphite aggregator.  Reporting every %d seconds of log data to %s" % (settings.carbon_interval_seconds, settings.carbon_host)
        self._reset_report(start_timestamp)
        
        # generate time group names
        self.time_group_names = []
        if len(settings.time_group_milliseconds) == 0:
            return
        self.time_group_names += ["under_%d_ms" % settings.time_group_milliseconds[0]]
        if len(settings.time_group_milliseconds) > 1:
            for i in range (1, len(settings.time_group_milliseconds)):
                self.time_group_names += ["%d_to_%d_ms" % (settings.time_group_milliseconds[i - 1], settings.time_group_milliseconds[i])]
        self.time_group_names += ["over_%d_ms" % settings.time_group_milliseconds[len(settings.time_group_milliseconds) - 1] ]
        print "Time groups: %s" % self.time_group_names


    def _reset_report(self, timestamp):
        self.counter_metric_totals = {} # key: metric name, value: cumulative counter value
        self.timer_metrics_totals = {} # key: metric name, value: cumulative timer value
        self.timer_metrics_entries = {} # key: metric name, value: number of entries for this timer
        self.time_groups = {} # key: metric name, value:  {tg_name ("click_under_20_ms"), total_entries}
        self.report_time = timestamp

        
    def increment(self, timestamp, tx_name, val=1.0):
        """
        #print "Incrementing %s at %d by %d" %(tx_name, timestamp, val)
        """
        if not self.counter_metric_totals.has_key(tx_name):
            self.counter_metric_totals[tx_name] = 0.0
        self.counter_metric_totals[tx_name] += val


    def __get_time_group__(self, tx_time):
        for i in range (0, len(settings.time_group_milliseconds)):
            if tx_time < settings.time_group_milliseconds [i]:
                return self.time_group_names[i]
        return self.time_group_names[len(settings.time_group_milliseconds)]
        
        
    def timing(self, timestamp, tx_name, tx_time):
        """
        there is an assumed order-of-operation by the caller where
        timing is called after increment has already been called for 
        the same log line
        """
        # 
        # mean time
        #
        if not self.timer_metrics_totals.has_key(tx_name):
            self.timer_metrics_totals[tx_name] = 0.0
        self.timer_metrics_totals [tx_name] += tx_time
        if not self.timer_metrics_entries.has_key(tx_name):
            self.timer_metrics_entries[tx_name] = 0.0
        self.timer_metrics_entries [tx_name] += 1.0
        #
        # time groupings
        #
        #print " -- %d -------- 1 --- %s" %(tx_time,self.time_groups)
        if len (settings.time_group_milliseconds) > 0:
            time_group_name = "%s_%s" % (tx_name, self.__get_time_group__(tx_time))
            if not self.time_groups.has_key(tx_name):
                self.time_groups [tx_name] = {}
            if not self.time_groups [tx_name].has_key(time_group_name):
                self.time_groups [tx_name][time_group_name] = 0.0
            self.time_groups [tx_name][time_group_name] += 1.0
        #print " ---------- 2 --- %s" %self.time_groups
        if timestamp > self.report_time:
            self.report_to_graphite()
            
    
    def report_to_graphite(self):
        #print "Reporting to graphite (%s:%d) at %d" % (settings.carbon_host, settings.carbon_port, self.report_time)
        graphite = socket.socket()
        graphite.connect((settings.carbon_host, settings.carbon_port))
        #
        # Report the counters
        # (calculate mean values per second)
        #
        for counter in self.counter_metric_totals.keys():
            # graphite data format: "metric_path value timestamp\n"
            metric_path = "%s.%s" % (GRAPHITE_PREFIX, counter)
            metric_value = self.counter_metric_totals[counter] / settings.carbon_interval_seconds
            graphite.sendall("%s %f %d\n" % (metric_path, metric_value, self.report_time))
            #print "    %s %f %d" % (metric_path, metric_value, self.report_time)
        #
        # Report the timers
        # (calculate mean)
        #
        for timer_name in self.timer_metrics_totals.keys():
            # mean
            mean_tx_name = "%s_time" % timer_name
            metric_path = "%s.%s" % (GRAPHITE_PREFIX, mean_tx_name)
            mean_value = self.timer_metrics_totals[timer_name] / self.timer_metrics_entries[timer_name]
            graphite.sendall("%s %f %d\n" % (metric_path, mean_value, self.report_time))
            #print "   %s %f %d" % (metric_path, mean_value, self.report_time)
        
        # calculate time groupings
        for tx_name in self.time_groups.keys():
            # get group total
            group_total=0
            for time_group in self.time_groups[tx_name].keys():
                group_total += self.time_groups [tx_name][time_group]
            for time_group in self.time_groups[tx_name].keys():
                rate = self.time_groups [tx_name][time_group] / group_total
                metric_path = "%s.%s" % (GRAPHITE_PREFIX, time_group)
                graphite.sendall("%s %f %d\n" % (metric_path, rate, self.report_time))
                #print "%s %f %d" % (metric_path, rate, self.report_time)

        # clean up            
        graphite.close()
        self._reset_report(self.report_time + settings.carbon_interval_seconds)

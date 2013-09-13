#!/usr/bin/python

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

from feeder import line # referenced in dynamic code execution
from feeder import aggregator
import datetime
import settings
from optparse import OptionParser
import sys

    
def ingest_log(line_reader, data_file):
    """
    Reads through the data file from start to finish.  Analyzes
    each line using the specified line analyzer
        
    Returns: timestamps for the first and last log file entries
    """
    print "Reading data file %s " % data_file
    stream = open(data_file)
    line = line_reader.get_first_data_line(stream)
    start_timestamp = line_reader.get_timestamp(line.split())
    graphite_aggregator = aggregator.GraphiteAggregator(start_timestamp)
    words = [] # scope needed outside loop
    while line:
        # process line
        words = line.split()
        timestamp = line_reader.get_timestamp(words)
        for tx_tuple in line_reader.get_counter_metrics(words):
            graphite_aggregator.increment(timestamp, tx_tuple[0], tx_tuple[1])
        timed_metrics = line_reader.get_timer_metrics(words)
        if not timed_metrics:
            # Grinder only records timing for transactions that pass
            line = stream.readline()
            continue
        for tx_tuple in timed_metrics:
            # [0] = tx name, [1] = timing data
            graphite_aggregator.timing(timestamp, tx_tuple[0], tx_tuple[1])
        line = stream.readline()
    end_timestamp = line_reader.get_timestamp(words)
    return (start_timestamp, end_timestamp)


def main():
    line_reader = None
    data_file = settings.default_data_file
    mapping_file = settings.default_mapping_file # referenced in dynamic code execution
    parser = OptionParser()
    parser.add_option("-m", "--mapping_file",
                      dest="mapping_file",
                      help="Grinder out* file with tx name/num mapings",
                      metavar="FILE")
    parser.add_option("-d", "--data_file",
                      dest="data_file",
                      help="grinder data file",
                      metavar="FILE")
    (options, args) = parser.parse_args()
    print "Options: %s" % options
    if options.data_file:
        data_file = options.data_file
    if options.mapping_file:
        mapping_file = options.mapping_file
    print "Using mapping file: %s, data file: %s" % (mapping_file, data_file)
    exec "line_reader = %s (mapping_file)" % settings.line_reader
    times = ingest_log (line_reader, data_file)
    print "Finished log ingestion.  Log data start: %d (%s), Log data end: %d (%s)" % (times[0],
                                                                              datetime.datetime.fromtimestamp(times[0]),
                                                                              times[1],
                                                                              datetime.datetime.fromtimestamp(times[1]))
  

if __name__ == "__main__":
    main()

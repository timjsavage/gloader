# Encoding: utf-8

require 'thor'

module GLoader

  class Build < Thor

    class_option :aws_id, type: :string, desc: 'AWS ID'
    class_option :aws_key, type: :string, desc: 'AWS key'
    class_option :verbose, type: :boolean, aliases: :v, desc: 'Verbose output'
    class_option :very_verbose, type: :boolean, aliases: :V, desc: 'VERY Verbose output'
    class_option :id, type: :string, desc: 'Platform ID to allow multi-tenancy in a single IaaS'

    desc 'status', 'Get the status of the platform'
    def status
    end

    desc 'create', 'Create a load test plaform'
    option :agents, type: :numeric, aliases: :a
    option :eip, type: :string, aliases: :e, desc: 'Elastic IP to use for the console'
    option :host, type: :string, aliases: :e, desc: 'Host name to use for the console'
    option :image, type: :string, desc: 'IaaS image to use'
    option :region, type: :string, desc: 'IaaS region to use'
    option :az, type: :string, desc: 'IaaS availablity zone to use'
    option :distribution, type: :string, aliases: :d, desc: 'Region Distibution'
    option :key_pair, type: :string, desc: 'Key Pair to use'
    option :agent_size, type: :string, desc: 'IaaS insance size to use for agents'
    option :console_size, type: :string, desc: 'IaaS insance size to use for the concole'
    def create
      confirmation = yes?('Are you sure?', :green)
      say('Created!', :green) if confirmation
    end

    desc 'destroy', 'Destroy a load test plaform'
    def destroy
      confirmation = yes?('Are you sure?', :green)
      say('Destroyed!', :green) if confirmation
    end

    desc 'failing', 'Report on which agents are failing'
    def failing
    end
  end

  class Test < Thor

    class_option :aws_id, type: :string, desc: 'AWS ID'
    class_option :aws_key, type: :string, desc: 'AWS key'
    class_option :verbose, type: :boolean, aliases: :v, desc: 'Verbose output'
    class_option :very_verbose, type: :boolean, aliases: :V, desc: 'VERY Verbose output'
    class_option :id, type: :string, desc: 'Platform ID to allow multi-tenancy in a single IaaS'

    desc 'init', 'Initiate load test platform'
    def init
    end

    desc 'results', 'Get test results'
    def results
    end

    desc 'finish', 'Finish a test run'
    def finish
    end

    desc 'status', 'Get the status of the load test agents'
    def status
    end

    desc 'push', 'Push scripts to agents'
    def push
    end

    desc 'test', 'Perform a test run'
    option :script, type: :string, aliases: :s, desc: 'Test script to use'
    option :property, type: :string, desc: 'Property to pass to agent'
    option :timed, type: :numeric, desc: 'Length of test in seconds'
    option :sleep_factor, type: :numeric, desc: 'Sleep factor'
    option :sleep_variation, type: :numeric, desc: 'Sleep variation'
    option :max_duration, type: :numeric, desc: 'Max process duration in milliseconds'
    option :processes, type: :numeric, aliases: :p, desc: 'Number of processes'
    option :threads, type: :numeric, aliases: :t, desc: 'Number of threads'
    option :runs, type: :numeric, aliases: :r, desc: 'Number of runs per thread'
    def test
    end

    desc 'get_logs', 'Get logs from the agents'
    option :log_sample, type: :numeric, desc: 'Number of servers to get logs from'
    def get_logs
    end

    desc 'report_ga', 'Generate a GrinderAnalyser report'
    option :save_report_to_s3, type: :boolean, desc: 'Save the report to S3'
    option :s3_bucket, type: :string, desc: 'S3 bucket to save to'
    option :report_tag, type: :string, desc: 'Tag to use in the report name'
    def report_ga
    end

    desc 'report_g2g', 'Send agent data to Graphite'
    option :report_tag, type: :string, desc: 'Tag to use in the report name'
    def report_g2g
    end
  end

  class CLI < Thor
    include Thor::Actions

    def self.start(*)
      super
    end

    desc 'build SUBCOMMAND ...ARGS', 'Build a load test platform'
    subcommand 'build', Build

    desc 'test SUBCOMMAND ...ARGS', 'Run a load test'
    subcommand 'test', Test
  end
end

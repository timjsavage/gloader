# Encoding: utf-8

require 'thor'
require 'active_support'

module GLoader

  class Default < Thor

    no_commands do
      def config
        config = GLoader::Config.new
        config.config(:state, options.except(:to_default))
        config
      end
    end

    class_option :aws_id, type: :string, desc: 'AWS ID'
    class_option :aws_key, type: :string, desc: 'AWS key'
    class_option :rackspace_id, type: :string, desc: 'Rackspace username'
    class_option :rackspace_key, type: :string, desc: 'Rackspace API key'
    class_option :verbose, type: :boolean, aliases: :v, desc: 'Verbose output'
    class_option :very_verbose, type: :boolean, aliases: :V, desc: 'VERY Verbose output'
    class_option :id, type: :string, desc: 'Platform ID to allow multi-tenancy in a single IaaS'
    class_option :non_interactive, aliases: :n, type: :boolean, desc: 'Non-interactive'

    desc 'save_config', 'Save config'
    option :to_default, type: :boolean, aliases: :d, desc: 'Save as defauilt config'
    def save_config
      type = options['to_default'] ? :default : :state
      config.config(type, options.except(:to_default), true)
      show_config
    end

    desc 'show_config', 'Show current config'
    def show_config
      puts config.combined.inspect
    end
  end

  class Build < Default

    desc 'status', 'Get the status of the platform'
    def status
      GLoader::Platform.new(config).status
    end

    desc 'create', 'Create a load test plaform'
    option :agents, type: :numeric, aliases: :a, desc: 'Number of agents required'
    option :region, type: :string, desc: 'IaaS region to use'
    option :distribution, type: :string, aliases: :d, desc: 'Region Distibution'
    option :agent_size,
           type: :string,
           desc: 'IaaS insance size to use for agents (small|medium|large)'
    option :console_size, type: :string, desc: 'IaaS insance size to use for the concole'
    def create
      confirmation = options[:non_interactive] || yes?('Are you sure?', :green)
      if confirmation
        GLoader::Platform.new(config).create
      else
        say('Aborted', :red)
      end
    end

    desc 'destroy', 'Destroy a load test plaform'
    def destroy
      confirmation = options[:non_interactive] || yes?('Are you sure?', :green)
      GLoader::Platform.new(config).destroy if confirmation
    end

    desc 'failing', 'Report on which agents are failing'
    def failing
    end
  end

  class Test < Default

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

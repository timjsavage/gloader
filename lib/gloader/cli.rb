# Encoding: utf-8

require 'thor'

module GLoader

  class Build < Thor
    class_option :verbose, type: :boolean, aliases: :v, desc: 'Verbose output'
    class_option :very_verbose, type: :boolean, aliases: :V, desc: 'VERY Verbose output'
    class_option :id, type: :string, desc: 'Platform ID to allow multi-tenancy in a single IaaS'

    desc 'status', 'Return the staus of the platform'
    def failing
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
    option :script_repo, type: :string, desc: 'Test script GIT repo to use'

    def create
      confirmation = yes?('Are you sure?', :green)
      say('Complete!', :green) if confirmation
    end

    desc 'destroy', 'Destroy a load test plaform'
    def destroy
      confirmation = yes?('Are you sure?', :green)
      say('Complete!', :green) if confirmation
    end

    desc 'failing', 'Report on which agents are failing'
    def failing
    end
  end

  class Test < Thor
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
    def test
    end

    desc 'get_logs', 'Get logs from the agents'
    def get_logs
    end

    desc 'report_ga', 'Generate a GrinderAnalyser report'
    def report_ga
    end

    desc 'report_g2g', 'Send agent data to Graphite'
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

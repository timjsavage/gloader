# Encoding: utf-8

require_relative 'console'
require_relative 'iaas'
require_relative 'chef'

module GLoader
  class Platform

    include GLoader::Iaas
    include GLoader::Chef
    include GLoader::Core

    def initialize(config = {})
      provider(config)
    end

    def status
      get_status
    end

    def create
      create_console && create_agents
    end

    def create_console
      # TODO
      # Create Insance
      # Create Chef node JSON
      # Converge using Chef
      provider.create_instance(:console) unless provider.get_console_instance.size == 1
    end

    def create_agents
      # TODO
      # Fork
      ## Create Insance
      ## Create Chef node JSON
      ## Converge using Chef
      provider.create_instance(:agent)
    end

    def destroy
      destroy_console && destroy_agents && destroy_dependencies
    end

    def destroy_console
      provider.destroy_instances(:console)
    end

    def destroy_agents
      provider.destroy_instances(:agent)
    end

    def destroy_dependencies
      provider.destroy
    end

    def deploy_scripts
    end

  end
end

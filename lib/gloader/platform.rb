# Encoding: utf-8

require 'formatador'
require_relative 'console'
require_relative 'iaas'

module GLoader
  class Platform

    include GLoader::Iaas
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
      provider.create_instance(:console, config[:region])
    end

    def create_agents
      provider.create_instance(:agent, config[:region])
    end

    def destroy
      destroy_console && destroy_agents
    end

    def destroy_console
      provider.destroy_instances(:console)
    end

    def destroy_agents
      provider.destroy_instances(:agent)
    end

    def deploy_scripts
    end

  end
end

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
      console = get_console
      agents  = get_agents

      unless (console + agents).count > 0
        Formatador.display_line('[red]No instances found[/]')
        return
      end

      output do
        Formatador.display_line('Console: ' + get_console_status(console))
        Formatador.display_line('Agents: ' + get_agents_status(agents))
        Formatador.display_line('Total: ' + (console + agents).count.to_s)
      end
    end

    def get_console
      provider.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_CONSOLE_TAG)
    end

    def get_agents
      provider.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_AGENT_TAG)
    end

    def get_console_status(console)
      if console.count == 1
        console.first.id + '(' +
        [console.first.dns_name,
         console.first.flavor_id].join(' - ') + ')'
      else
        'Not running'
      end
    end

    def get_agents_status(agents)
      if agents.count > 0
        agents.first.id + '(e.g. ' +
        [agents.first.dns_name,
         agents.first.flavor_id].join(' - ') + ')'
      else
        '0'
      end
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

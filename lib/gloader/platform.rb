# Encoding: utf-8

require 'formatador'
require_relative 'console'
require_relative 'iaas'

module GLoader
  class Platform

    include GLoader::Iaas
    include GLoader::Core

    def status
      console = get_console
      agents  = get_agents

      unless (console + agents).count > 0
        Formatador.display_line('[red]No instances found[/]')
        return
      end

      output do
        Formatador.display_line('Console: ' + get_console_status)
      end

      output do
        Formatador.display_line('Agent: ' + get_agents_status)
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
         console.first.flavor_id,
         console.first.availability_zone].join(' - ') + ')'
      else
        'Not running'
      end
    end

    def get_agents_status(agents)
      if agents.count > 0
        agents.first.id + '(e.g. ' +
        [agents.first.dns_name,
         agents.first.flavor_id,
         agents.first.availability_zone].join(' - ') + ')'
      else
        '0'
      end
    end

    def create
    end

    def create_console
    end

    def create_agents
    end

    def destroy
    end

    def destroy_agents
    end

    def destroy_console
    end

    def deploy_scripts
    end

  end
end

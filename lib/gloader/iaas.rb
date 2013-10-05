# Encoding: utf-8

require 'formatador'

require_relative 'iaas/aws'
require_relative 'iaas/rackspace'

LOAD_TEST_PLATFORM_GROUP_TAG   = 'gloader-platform'
LOAD_TEST_PLATFORM_TAG_NAME    = 'gloader-platform-type'
LOAD_TEST_PLATFORM_CONSOLE_TAG = 'gloader-platform-console'
LOAD_TEST_PLATFORM_AGENT_TAG   = 'gloader-platform-agent'
LOAD_TEST_PLATFORM_TAG_NAME_ID = 'gloader-platform-id'

module GLoader
  module Iaas
    def provider(config = {})
      @provider ||= GLoader::Iaas::Aws.new(config)
    end

    def get_console_instance
      provider.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_CONSOLE_TAG)
    end

    def get_agents_instances
      provider.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_AGENT_TAG)
    end

    def get_status
      console = get_console_instance
      agents  = get_agents_instances

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
  end
end

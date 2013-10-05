# Encoding: utf-8

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
  end
end

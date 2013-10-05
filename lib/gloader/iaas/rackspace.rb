# Encoding: utf-8

# http://docs.rackspace.com/servers/api/v2/cs-releasenotes/content/supported_flavors.html
# https://github.com/fog/fog/blob/master/lib/fog/rackspace/docs/compute_v2.md
# http://bit.ly/191SvA0
# http://www.ruby-doc.org/gems/docs/t/tag-fog-1.0.1/Fog/Compute/Rackspace/Real.html

require 'fog'
require 'slowweb'

module GLoader
  module Iaas
    class Rackspace

      include GLoader::Core
      include GLoader::Logger

      DEFAULTS = {
        platform_id:            'default',
        instance_size_agent:    '4',
        instance_size_console:  '4',
        region:                 'lon',
        availability_zone:      '',
        distribution:           'single',
        security_group:         'gloader'
      }

      def initialize(config = {})
        config(config)
        rate_limit
      end

      def config(config = {})
        @config ||= DEFAULTS
        @config.merge!(config)
      end

      def rate_limit
        SlowWeb.limit('rackspacecloud.com', 60, 60) if SlowWeb.get_limit('rackspacecloud.com').nil?
      end

      def connection
        @connection ||= Fog::Compute.new({
          provider:           'Rackspace',
          rackspace_username: config[:rackspace_username],
          rackspace_api_key:  config[:rackspace_api_key],
          rackspace_auth_url: Fog::Rackspace::UK_AUTH_ENDPOINT,
          rackspace_region:   :lon,
          version:            :v2
        })
      end

      def connection_storage
        @connection_storage ||= Fog::Storage.new({
          provider:           'Rackspace',
          rackspace_username: config[:rackspace_username],
          rackspace_api_key:  config[:rackspace_api_key],
          rackspace_auth_url: Fog::Rackspace::UK_AUTH_ENDPOINT,
          rackspace_region:   :lon
        })
      end

      def destroy
      end
    end
  end
end

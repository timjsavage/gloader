# Encoding: utf-8

# http://docs.rackspace.com/servers/api/v2/cs-releasenotes/content/supported_flavors.html
# https://github.com/fog/fog/blob/master/lib/fog/rackspace/docs/compute_v2.md
# http://bit.ly/191SvA0 - Bootstrapping an Ubuntu Server on Rackspace Using Cloud-Init and Fog
# http://www.ruby-doc.org/gems/docs/t/tag-fog-1.0.1/Fog/Compute/Rackspace/Real.html

require 'fog'
require 'slowweb'

module GLoader
  module Iaas

    ##
    # Rackspace specific IaaS integration

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

      def regions
        {
          lon: {  image_id: 'dfc65210-334c-4a7e-a312-be7a68b21b37',
                  auth_url: Fog::Rackspace::UK_AUTH_ENDPOINT,
                  weight: 1 },
          dfw: {  image_id: 'c6f9c411-e708-4952-91e5-62ded5ea4d3e',
                  auth_url: Fog::Rackspace::US_AUTH_ENDPOINT,
                  weight: 1 },
          ord: {  image_id: 'c6f9c411-e708-4952-91e5-62ded5ea4d3e',
                  auth_url: Fog::Rackspace::US_AUTH_ENDPOINT,
                  weight: 1 }
        }
      end

      def connection(region)
        @connection ||= {}
        if @connection.key?(region)
          @connection[region]
        else
          @connection.merge!(region => Fog::Compute.new(
            provider:           'Rackspace',
            rackspace_username: config[:rackspace_id],
            rackspace_api_key:  config[:rackspace_key],
            rackspace_auth_url: regions[region][:rackspace_auth_url],
            rackspace_region:   :lon,
            version:            :v2
          ))
        end
        @connection[region]
      end

      def connection_storage
        @connection_storage ||= Fog::Storage.new(
          provider:           'Rackspace',
          rackspace_username: config[:rackspace_id],
          rackspace_api_key:  config[:rackspace_key],
          rackspace_auth_url: Fog::Rackspace::UK_AUTH_ENDPOINT,
          rackspace_region:   :lon
        )
      end

      def destroy_dependencies
      end
    end
  end
end

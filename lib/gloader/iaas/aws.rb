# Encoding: utf-8

require 'fog'
require 'slowweb'

module GLoader
  module Iaas
    class Aws

      include GLoader::Core
      include GLoader::Logger

      DEFAULTS = {
        platform_id:            'default',
        instance_size_agent:    'm1.medium',
        instance_size_console:  'm1.medium',
        region:                 'eu-west-1',
        availability_zone:      '',
        distribution:           'single'
      }

      def initialize(config = {})
        config(config)
        SlowWeb.limit('amazonaws.com', 60, 60) if SlowWeb.get_limit('amazonaws.com').nil?
      end

      def config(config = {})
        @config ||= DEFAULTS
        @config.merge!(config)
      end

      def aws_regions
        {
          'eu-west-1'       => { ami: 'ami-ca1a14be', weight: 1 },
          'ap-northeast-1'  => { ami: 'ami-0366e302', weight: 1 },
          'ap-southeast-1'  => { ami: 'ami-42e1a310', weight: 1 },
          'ap-southeast-2'  => { ami: 'ami-eebd2bd4', weight: 1 },
          'sa-east-1'       => { ami: 'ami-2f6ab232', weight: 1 },
          'us-east-1'       => { ami: 'ami-21e47148', weight: 1 },
          'us-west-1'       => { ami: 'ami-e63013a3', weight: 1 },
          'us-west-2'       => { ami: 'ami-6ec8425e', weight: 1 }
        }
      end

      def connection(region)
        @connection ||= {}
        if @connection.key?(region)
          @connection[region]
        else
          @connection.merge!({ region => Fog::Compute.new({
            provider:                'AWS',
            aws_access_key_id:        config[:aws_access_key_id],
            aws_secret_access_key:    config[:aws_secret_access_key],
            region:                   region
          }) })
        end
        @connection[region]
      end

      def connection_s3
        @connection_s3 ||= Fog::Storage.new({
          provider:                 'AWS',
          aws_access_key_id:        config[:aws_access_key_id],
          aws_secret_access_key:    config[:aws_secret_access_key],
        })
      end

      def find_instances_by_tag(tag, value)
        found_servers = false
        aws_regions.each do |region, values|
          servers = connection(region).servers.select do |server|
            server.tags.any? do |server_tag, server_value|
              instance_matches_tag?(server, tag, value, server_tag, server_value)
            end &&
            server.tags.any? do |server_tag, server_value|
              instance_matches_platform?(server_tag, server_value)
            end
          end
          found_servers ? found_servers.concat(servers) : found_servers = servers
        end
        found_servers
      end

      def instance_matches_tag?(server, tag, value, server_tag, server_value)
        server_tag == tag &&
        server_value == value &&
        server.state != 'terminated' &&
        server.state != 'shutting-down'
      end

      def instance_matches_platform?(server_tag, server_value)
        server_tag == LOAD_TEST_PLATFORM_TAG_NAME_ID &&
        server_value == config[:platform_id]
      end

      def instance_image(region)
        raise ArgumentError unless aws_regions[region]
        aws_regions[region][:ami]
      end

      def instance_size(type)
        raise ArgumentError unless type == :agent || type == :console
        if type == :agent
          'm1.medium'
        else
          'm1.medium'
        end
      end

      def key_pair_name
        LOAD_TEST_PLATFORM_GROUP_TAG
      end

      def private_key_path(region)
        File.expand_path "~/.ssh/#{LOAD_TEST_PLATFORM_GROUP_TAG}-#{region}.key".gsub('_', '-')
      end

      def key_pair(region)
        create_key_pair(region)
        key_pair_name
      end

      def key_pair_exists?(region)
        connection(region).key_pairs.get(key_pair_name).nil? ? false : true
      end

      def private_key_exists?(region)
        File.readable?(private_key_path(region))
      end

      def create_key_pair(region)
        if key_pair_exists?(region) && private_key_exists?(region)
          connection(region).key_pairs.get(key_pair_name)
        else
          delete_key_pair(region)
          delete_private_key(region)
          key = connection(region).key_pairs.create({ name: key_pair_name })
          File.open(private_key_path(region), 'w', 0600) { |f| f.write(key.private_key) }
          key
        end
      end

      def delete_key_pair(region)
        logger.info "Deleting  key pair: #{key_pair_name}"
        connection(region).delete_key_pair(key_pair_name) if key_pair_exists?(region)
      end

      def delete_private_key(region)
        logger.info "Deleting private key: #{private_key_path(region)}"
        File.delete private_key_path(region) if File.exist? private_key_path(region)
      end

      def platform_id
        config[:platform_id]
      end

      def instance_tags(type)
        if type == :agent
          {
            LOAD_TEST_PLATFORM_TAG_NAME     => LOAD_TEST_PLATFORM_AGENT_TAG,
            LOAD_TEST_PLATFORM_TAG_NAME_ID  => platform_id,
            LOAD_TEST_PLATFORM_GROUP_TAG    => 'true',
            'Name'                          => "#{LOAD_TEST_PLATFORM_AGENT_TAG} (#{platform_id})",
          }
        else
          {
            LOAD_TEST_PLATFORM_TAG_NAME     => LOAD_TEST_PLATFORM_CONSOLE_TAG,
            LOAD_TEST_PLATFORM_TAG_NAME_ID  => platform_id,
            LOAD_TEST_PLATFORM_GROUP_TAG    => 'true',
            'Name'                          => "#{LOAD_TEST_PLATFORM_CONSOLE_TAG} (#{platform_id})",
          }
        end
      end

      def instance_attributes(type, region)
        {
          availability_zone:  '',
          image_id:           instance_image(region),
          flavor_id:          instance_size(type),
          key_name:           key_pair(region),
          tags:               instance_tags(region)
        }
      end

      def create_instance(type, region)
        logger.info "Creating instance: #{type.to_s} in #{region}"
        raise ArgumentError unless type == :agent || type == :console
        raise ArgumentError unless aws_regions[region]
        Fog.credentials = Fog.credentials.merge({ private_key_path: private_key_path(region) })
        server = connection(region).servers.bootstrap(instance_attributes(type, region))
        server.wait_for(Fog.timeout, 5) { ready? && sshable? }
        server
      end
    end
  end
end

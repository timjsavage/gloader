# Encoding: utf-8

require 'fog'
require 'sshkey'
require 'slowweb'
require 'active_support'

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
        distribution:           'single',
        security_group:         'gloader'
      }

      def initialize(config = {})
        config(config)
        rate_limit
        unless config[:init] == false
          create_security_groups
          create_local_keys
        end
      end

      def config(config = {})
        @config ||= DEFAULTS
        @config.merge!(config).symbolize_keys!
      end

      def rate_limit
        SlowWeb.limit('amazonaws.com', 60, 60) if SlowWeb.get_limit('amazonaws.com').nil?
      end

      def destroy
        destroy_keys
        destroy_security_groups
      end

      def regions
        {
          'eu-west-1'       => { image_id: 'ami-ca1a14be', weight: 1 },
          'ap-northeast-1'  => { image_id: 'ami-0366e302', weight: 1 },
          'ap-southeast-1'  => { image_id: 'ami-42e1a310', weight: 1 },
          'ap-southeast-2'  => { image_id: 'ami-eebd2bd4', weight: 1 },
          'sa-east-1'       => { image_id: 'ami-2f6ab232', weight: 1 },
          'us-east-1'       => { image_id: 'ami-21e47148', weight: 1 },
          'us-west-1'       => { image_id: 'ami-e63013a3', weight: 1 },
          'us-west-2'       => { image_id: 'ami-6ec8425e', weight: 1 }
        }
      end

      def connection(region)
        @connection ||= {}
        if @connection.key?(region)
          @connection[region]
        else
          @connection.merge!({ region => Fog::Compute.new({
            provider:               'AWS',
            aws_access_key_id:      config[:aws_id],
            aws_secret_access_key:  config[:aws_key],
            region:                 region
          }) })
        end
        @connection[region]
      end

      def connection_storage
        @connection_storage ||= Fog::Storage.new({
          provider:               'AWS',
          aws_access_key_id:      config[:aws_id],
          aws_secret_access_key:  config[:aws_key]
        })
      end

      def find_instances_by_tag(tag, value)
        found_servers = []
        regions.each do |region, values|
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

      def get_console_instance
        find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_CONSOLE_TAG)
      end

      def get_agent_instances
        find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, LOAD_TEST_PLATFORM_AGENT_TAG)
      end

      def instance_image(region)
        raise ArgumentError unless regions[region]
        regions[region][:image_id]
      end

      def instance_size(type)
        raise ArgumentError unless type == :agent || type == :console
        if type == :agent
          config[:instance_size_agent]
        else
          config[:instance_size_console]
        end
      end

      def create_security_groups
        regions.each { |region, config| create_security_group(region) }
      end

      def destroy_security_groups
        regions.each { |region, config| destroy_security_group(region) }
      end

      def create_security_group(region)
        security_group = config[:security_group]
        unless connection(region).security_groups.map { |s|s.name }.include?(security_group)
          connection(region).create_security_group(security_group, security_group)
          [22, 6372, 6373].each do |port|
            open_port(region, security_group, port)
          end
        end
      end

      def open_port(region, security_group, port)
        connection(region).authorize_security_group_ingress(
          security_group,
          { 'CidrIp'      => '0.0.0.0/0',
            'IpProtocol'  => 'tcp',
            'FromPort'    => port,
            'ToPort'      => port }
        )
      end

      def destroy_security_group(region)
        security_group = config[:security_group]
        if connection(region).security_groups.map { |s|s.name }.include?(security_group)
          connection(region).delete_security_group(security_group)
        end
      end

      def key_name(prefix = false)
        (prefix ? 'fog_' : '') + LOAD_TEST_PLATFORM_GROUP_TAG.sub('-', '_')
      end

      def key_path(type)
        path = File.expand_path ".#{LOAD_TEST_PLATFORM_GROUP_TAG}-#{type.to_s}.key"
        path.sub!('.key', '-test.key') if ENV['GEM_ENV'] == 'test'
        path.sub('-', '_')
      end

      def destroy_keys
        regions.each do |region, config|
          destroy_iaas_key(region)
        end
        destroy_local_keys
      end

      def iaas_key_exists?(region)
        connection(region).key_pairs.get(key_name(true)).nil? ? false : true
      end

      def local_keys_exists?
        File.readable?(key_path(:private)) && File.readable?(key_path(:public))
      end

      def create_local_keys
        unless local_keys_exists?
          destroy_keys
          keys = SSHKey.generate
          File.open(key_path(:public), 'w', 0600) { |f| f.write(keys.ssh_public_key) }
          File.open(key_path(:private), 'w', 0600) { |f| f.write(keys.private_key) }
        end
      end

      def destroy_iaas_key(region)
        logger.info "Deleting  key pair: #{key_name}"
        connection(region).delete_key_pair(key_name(true)) if iaas_key_exists?(region)
      end

      def destroy_local_keys
        logger.info "Deleting private key: #{key_path(:private)}"
        File.delete key_path(:private) if File.exist? key_path(:private)
        File.delete key_path(:public) if File.exist? key_path(:public)
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
        elsif type == :console
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
          private_key_path:   key_path(:private),
          public_key_path:    key_path(:public),
          tags:               instance_tags(type)
        }
      end

      def create_instance(type, region = nil)
        raise ArgumentError unless type == :agent || type == :console
        region = config[:region] if region.nil?
        logger.info "Creating instance: #{type.to_s} in #{region}"
        server = bootstrap_instance(type, region)
        server.wait_for(Fog.timeout, 5) { ready? && sshable? }
        logger.info "Created instance (#{server.id}): #{type.to_s} in #{region}"
        server
      end

      def bootstrap_instance(type, region)
        Fog.credential = key_name
        connection(region).servers.bootstrap(instance_attributes(type, region))
      end

      def destroy_instances(type)
        logger.info "Destroying instances: #{type.to_s}"
        raise ArgumentError unless type == :agent || type == :console

        tag = type == :console ? LOAD_TEST_PLATFORM_CONSOLE_TAG : LOAD_TEST_PLATFORM_AGENT_TAG

        servers = find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME, tag)
        servers.each do |server|
          server.destroy
        end
      end
    end
  end
end

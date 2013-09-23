# Encoding: utf-8

module GLoader
  class Iaas

    include GLoader::Core

    def initialize(config = {})
      @config = config
    end

    def config(config = {})
      @config ||= {}
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

    def find_servers_by_tag(tag, value, platform_id_filter = true)
      found_servers = false
      aws_regions.each do |region, values|
        servers = connection(region).servers.select do |server|
          server.tags.any? do |server_tag, server_value|
            server_tag == tag &&
            server_value == value &&
            server.state != 'terminated' &&
            server.state != 'shutting-down'
          end &&
          server.tags.any? do |server_tag, server_value|
            server_tag == LOAD_TEST_PLATFORM_TAG_NAME_ID && server_value == config[:platform_id]
          end
        end
        found_servers ? found_servers.concat(servers) : found_servers = servers
      end
      found_servers
    end

  end
end

# Encoding: utf-8

require_relative '../spec_helper'

require 'fog'

describe GLoader do
  describe GLoader::Iaas do

    let(:gloader) do
      GLoader::Iaas.new({ aws_access_key_id:      'foo',
                          aws_secret_access_key:  'bar',
                          platform_id:            'default' })
    end

    def create_console
      gloader.connection('eu-west-1').servers.create({
        availability_zone:  'a',
        image_id:           'ami-ca1a14be',
        flavor_id:          'm1.medium',
        tags: {
          LOAD_TEST_PLATFORM_TAG_NAME     => LOAD_TEST_PLATFORM_CONSOLE_TAG,
          LOAD_TEST_PLATFORM_TAG_NAME_ID  => 'default',
          LOAD_TEST_PLATFORM_GROUP_TAG    => 'true',
          'Name'                          => "#{LOAD_TEST_PLATFORM_CONSOLE_TAG} (default)",
          'AgentID'                       => 1
        }
      })
    end

    def create_agent(region)
      gloader.connection(region).servers.create({
        availability_zone:  'a',
        image_id:           'ami-ca1a14be',
        flavor_id:          'm1.medium',
        tags: {
          LOAD_TEST_PLATFORM_TAG_NAME     => LOAD_TEST_PLATFORM_AGENT_TAG,
          LOAD_TEST_PLATFORM_TAG_NAME_ID  => 'default',
          LOAD_TEST_PLATFORM_GROUP_TAG    => 'true',
          'Name'                          => "#{LOAD_TEST_PLATFORM_AGENT_TAG} (default)",
          'AgentID'                       => 1
        }
      })
    end

    describe '#aws_regions' do
      it 'should return a hash of Iaas regions' do
        gloader.aws_regions.length.must_equal 8
        gloader.aws_regions['eu-west-1'][:ami].must_equal 'ami-ca1a14be'
        gloader.aws_regions.each_pair do |region, config|
          config[:ami].must_match /^ami-[a-z0-9]+$/
          config[:weight].must_be_instance_of Fixnum
        end
      end
    end

    describe '#connection' do

      before(:each) do
        Fog.mock!
      end

      after(:each) do
        Fog::Mock.reset
      end

      it 'should return a connection for a region' do
        gloader_conn = GLoader::Iaas.new({ aws_access_key_id: 'foo', aws_secret_access_key: 'bar' })
        gloader_conn.connection('eu-west-1').must_be_instance_of Fog::Compute::AWS::Mock
        gloader_conn.connection('eu-west-1').region.must_equal 'eu-west-1'
        gloader_conn.connection('us-east-1').region.must_equal 'us-east-1'
      end

      it 'will raise if region is empty' do
        gloader_conn = GLoader::Iaas.new({ aws_access_key_id: 'foo', aws_secret_access_key: 'bar' })
        assert_raises(ArgumentError) { gloader_conn.connection }
      end
    end

    describe '#connection_s3' do

      before(:each) do
        Fog.mock!
      end

      after(:each) do
        Fog::Mock.reset
      end

      it 'should return a S3 connection for a region' do
        gloader_conn = GLoader::Iaas.new({ aws_access_key_id: 'foo', aws_secret_access_key: 'bar' })
        gloader_conn.connection_s3.must_be_instance_of Fog::Storage::AWS::Mock
        gloader_conn.connection_s3.directories.must_be_instance_of Fog::Storage::AWS::Directories
        gloader_conn.connection_s3.directories.must_equal []
      end
    end

    describe '#find_servers_by_tag' do

      before(:each) do
        Fog.mock!
        Fog::Mock.delay = 0
      end

      after(:each) do
        Fog::Mock.reset
      end

      it 'will raise if app name is empty' do
        gloader_conn = GLoader::Iaas.new({ aws_access_key_id: 'foo',
                                           aws_secret_access_key: 'bar',
                                           platform_id: 'default' })
        assert_raises(ArgumentError) { gloader_conn.find_servers_by_tag }
      end

      it 'will return no instances if there aren\'t any' do
        gloader_conn = GLoader::Iaas.new({ aws_access_key_id: 'foo',
                                           aws_secret_access_key: 'bar',
                                           platform_id: 'default' })
        gloader_conn.find_servers_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                         LOAD_TEST_PLATFORM_AGENT_TAG).must_equal []
      end

      it 'will return agent instances based on tags' do
        create_console
        create_agent('eu-west-1')
        create_agent('us-east-1')
        servers = gloader.find_servers_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                              LOAD_TEST_PLATFORM_AGENT_TAG)
        servers.size.must_equal 2
        servers.first.must_be_instance_of Fog::Compute::AWS::Server
      end

      it 'will return console instances based on tags' do
        create_console
        create_agent('eu-west-1')
        create_agent('us-east-1')
        servers = gloader.find_servers_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                              LOAD_TEST_PLATFORM_CONSOLE_TAG)
        servers.size.must_equal 1
        servers.first.must_be_instance_of Fog::Compute::AWS::Server
      end
    end

  end
end

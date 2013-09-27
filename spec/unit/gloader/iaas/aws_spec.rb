# Encoding: utf-8

require_relative '../../spec_helper'

describe GLoader do
  describe GLoader::Iaas do
    describe GLoader::Iaas::Aws do

      before(:each) do
        Fog.mock!
        Fog::Mock.delay = 0
      end

      after(:each) do
        Fog::Mock.reset
        gloader.aws_regions.each do |region, values|
          gloader.delete_private_key(region)
        end
      end

      let(:gloader) do
        GLoader::Iaas::Aws.new({ aws_access_key_id:      'foo',
                                 aws_secret_access_key:  'bar',
                                 platform_id:            'default' })
      end

      def create_console
        gloader.connection('eu-west-1').servers.create({
          availability_zone:  '',
          image_id:           'ami-ca1a14be',
          flavor_id:          'm1.medium',
          tags: {
            LOAD_TEST_PLATFORM_TAG_NAME     => LOAD_TEST_PLATFORM_CONSOLE_TAG,
            LOAD_TEST_PLATFORM_TAG_NAME_ID  => 'default',
            LOAD_TEST_PLATFORM_GROUP_TAG    => 'true',
            'Name'                          => "#{LOAD_TEST_PLATFORM_CONSOLE_TAG} (default)",
          }
        })
      end

      def create_agent(region)
        gloader.connection(region).servers.create({
          availability_zone:  '',
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

      def create_other(region)
        gloader.connection(region).servers.create({
          availability_zone:  '',
          image_id:           'ami-ca1a14be',
          flavor_id:          'm1.medium',
          tags: {
            'Name' => 'Other Instance'
          }
        })
      end

      describe '#config' do
        it 'should return default config' do
          gloader.config[:instance_size_agent].must_equal 'm1.medium'
          gloader.config[:instance_size_console].must_equal 'm1.medium'
          gloader.config[:aws_access_key_id].must_equal 'foo'
        end
      end

      describe '#rate_limit' do
        it 'should add a rate limiter for the iaas api' do
          gloader.rate_limit
          SlowWeb.get_limit('amazonaws.com').host.must_equal 'amazonaws.com'
        end
        it 'should not add another rate limiter if one has already been set' do
          gloader.rate_limit
          gloader.rate_limit
          SlowWeb.get_limit('amazonaws.com').host.must_equal 'amazonaws.com'
        end
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
        it 'should return a connection for a region' do
          gloader.connection('eu-west-1').must_be_instance_of Fog::Compute::AWS::Mock
          gloader.connection('eu-west-1').region.must_equal 'eu-west-1'
          gloader.connection('us-east-1').region.must_equal 'us-east-1'
        end
        it 'will raise if region is empty' do
          assert_raises(ArgumentError) { gloader.connection }
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
          gloader.connection_s3.must_be_instance_of Fog::Storage::AWS::Mock
          gloader.connection_s3.directories.must_be_instance_of Fog::Storage::AWS::Directories
          gloader.connection_s3.directories.must_equal []
        end
      end

      describe '#find_instances_by_tag' do
        it 'will raise if region is not passed' do
          assert_raises(ArgumentError) { gloader.find_instances_by_tag }
        end
        it 'will return no instances if there aren\'t any' do
          gloader.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                        LOAD_TEST_PLATFORM_AGENT_TAG).must_equal []
        end
        it 'will return agent instances based on tags' do
          create_console
          create_agent('eu-west-1')
          create_agent('us-east-1')
          create_other('us-east-1')
          servers = gloader.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                                  LOAD_TEST_PLATFORM_AGENT_TAG)
          servers.size.must_equal 2
          servers.first.must_be_instance_of Fog::Compute::AWS::Server
          servers.each do |server|
            server.tags['Name'].wont_equal 'Other Instance'
          end
        end
        it 'will return console instances based on tags' do
          create_console
          create_agent('eu-west-1')
          create_agent('us-east-1')
          create_other('us-east-1')
          servers = gloader.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                                  LOAD_TEST_PLATFORM_CONSOLE_TAG)
          servers.size.must_equal 1
          servers.first.must_be_instance_of Fog::Compute::AWS::Server
          servers.each do |server|
            server.tags['Name'].wont_equal 'Other Instance'
          end
        end
      end

      describe '#instance_image' do
        it 'will return an image id for a region' do
          gloader.instance_image('eu-west-1').must_equal 'ami-ca1a14be'
        end
        it 'will raise for an invalid region' do
          assert_raises(ArgumentError) { gloader.instance_image('foo') }
        end
      end

      describe '#instance_size' do
        it 'will return an image size for an instance type' do
          gloader.instance_size(:agent).must_equal 'm1.medium'
          gloader.instance_size(:console).must_equal 'm1.medium'
        end
        it 'will raise for an invalid instance type' do
          assert_raises(ArgumentError) { gloader.instance_size('foo') }
        end
      end

      describe '#instance_tags' do
        it 'will return instance tags for a agent instance' do
          gloader.instance_tags(:agent)[LOAD_TEST_PLATFORM_TAG_NAME].must_equal \
            LOAD_TEST_PLATFORM_AGENT_TAG
          gloader.instance_tags(:agent)[LOAD_TEST_PLATFORM_GROUP_TAG].must_equal 'true'
        end
        it 'will return instance tags for a console instance' do
          gloader.instance_tags(:console)[LOAD_TEST_PLATFORM_TAG_NAME].must_equal \
            LOAD_TEST_PLATFORM_CONSOLE_TAG
          gloader.instance_tags(:console)[LOAD_TEST_PLATFORM_GROUP_TAG].must_equal 'true'
        end
      end

      describe '#platform_id' do
        it 'will return a platform id' do
          gloader.platform_id.must_equal 'default'
        end
      end

      describe '#key_pair' do
        it 'will return a region\'s key pair' do
          gloader.key_pair('eu-west-1').must_equal LOAD_TEST_PLATFORM_GROUP_TAG
        end
      end

      describe '#key_pair_exists?' do
        it 'will return false if a key doesn\'t exist' do
          region = 'eu-west-1'
          gloader.key_pair_exists?(region).must_equal false
        end
        it 'will return true if a key already exists' do
          region = 'eu-west-1'
          gloader.create_key_pair(region)
          gloader.key_pair_exists?(region).must_equal true
        end
      end

      describe '#private_key_exists?' do
        it 'will return false if a private key doesn\'t exist' do
          region = 'eu-west-1'
          gloader.private_key_exists?(region).must_equal false
        end
        it 'will return true if a key already exists' do
          region = 'eu-west-1'
          gloader.create_key_pair(region)
          gloader.private_key_exists?(region).must_equal true
        end
      end

      describe '#create_key_pair' do
        it 'will create a key and key file' do
          region = 'eu-west-1'
          key = gloader.create_key_pair(region)
          key.must_be_instance_of Fog::Compute::AWS::KeyPair
          IO.read(gloader.private_key_path(region)).must_equal key.private_key
        end
        it 'will not create a key and key file if they already exist' do
          region = 'eu-west-1'
          gloader.create_key_pair(region)
          key = gloader.create_key_pair(region)
          key.must_be_instance_of Fog::Compute::AWS::KeyPair
        end
        it 'will create a key and key file if a key pair but no private key file exists' do
          region = 'eu-west-1'
          gloader.create_key_pair(region)
          private_key_path = gloader.private_key_path(region)
          File.delete(private_key_path)

          key = gloader.create_key_pair(region)
          IO.read(gloader.private_key_path(region)).must_equal key.private_key
        end
        it 'will create a key and key file if a private key file but no key pair exists' do
          region = 'eu-west-1'
          gloader.create_key_pair(region)
          gloader.connection(region).delete_key_pair(gloader.key_pair_name)

          key = gloader.create_key_pair(region)
          IO.read(gloader.private_key_path(region)).must_equal key.private_key
        end
      end

      describe '#key_pair_name' do
        it 'will return a key pair name' do
          gloader.key_pair_name.must_equal LOAD_TEST_PLATFORM_GROUP_TAG
        end
      end

      describe '#instance_attributes' do
        it 'will return attributes for a console instance' do
          region = 'eu-west-1'
          type = :console
          attr = gloader.instance_attributes(type, region)
          attr[:tags][LOAD_TEST_PLATFORM_GROUP_TAG].must_equal 'true'
          attr[:image_id].must_equal gloader.aws_regions[region][:ami]
        end
      end

      describe '#create_instance' do
        it 'will create an agent instance' do
          gloader.create_instance(:agent, 'eu-west-1').must_be_instance_of Fog::Compute::AWS::Server
        end
        it 'will create a console instance' do
          server = gloader.create_instance(:console, 'eu-west-1')
          server.must_be_instance_of Fog::Compute::AWS::Server
          servers = gloader.find_instances_by_tag(LOAD_TEST_PLATFORM_TAG_NAME,
                                                  LOAD_TEST_PLATFORM_CONSOLE_TAG)
          servers.size.must_equal 1
        end
        it 'will raise for an invalid instance type' do
          assert_raises(ArgumentError) { gloader.create_instance('foo', 'eu-west-1') }
        end
        it 'will raise for an invalid region' do
          assert_raises(ArgumentError) { gloader.create_instance(:agent, 'foo') }
        end
      end
    end
  end
end

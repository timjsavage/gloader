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
        subject.destroy
      end

      subject do
        aws_config = GLoader::Config.new
        aws_config.config(:default, { aws_id:       'foo',
                                      aws_key:      'bar',
                                      platform_id:  'default',
                                      init:         false })
        GLoader::Iaas::Aws.new(aws_config)
      end

      def create_console(region = 'eu-west-1')
        subject.connection(region).servers.create({
          image_id:           'ami-ca1a14be',
          flavor_id:          'm1.medium',
          tags: {
            GLOADER_PLATFORM_AWS_TAG_NAME     => GLOADER_PLATFORM_AWS_CONSOLE_TAG,
            GLOADER_PLATFORM_AWS_TAG_NAME_ID  => 'default',
            GLOADER_PLATFORM_AWS_GROUP_TAG    => 'true',
            'Name'                          => "#{GLOADER_PLATFORM_AWS_CONSOLE_TAG} (default)",
          }
        })
      end

      def create_agent(region)
        subject.connection(region).servers.create({
          image_id:           'ami-ca1a14be',
          flavor_id:          'm1.medium',
          tags: {
            GLOADER_PLATFORM_AWS_TAG_NAME     => GLOADER_PLATFORM_AWS_AGENT_TAG,
            GLOADER_PLATFORM_AWS_TAG_NAME_ID  => 'default',
            GLOADER_PLATFORM_AWS_GROUP_TAG    => 'true',
            'Name'                          => "#{GLOADER_PLATFORM_AWS_AGENT_TAG} (default)",
            'AgentID'                       => 1
          }
        })
      end

      def create_other(region)
        subject.connection(region).servers.create({
          image_id:           'ami-ca1a14be',
          flavor_id:          'm1.medium',
          tags: {
            'Name' => 'Other Instance'
          }
        })
      end

      describe '#constants' do
        it 'should have tag constants set' do
          GLOADER_PLATFORM_AWS_GROUP_TAG.must_equal 'gloader-platform'
          GLOADER_PLATFORM_AWS_TAG_NAME.must_equal 'gloader-platform-type'
          GLOADER_PLATFORM_AWS_CONSOLE_TAG.must_equal 'gloader-platform-console'
          GLOADER_PLATFORM_AWS_AGENT_TAG.must_equal 'gloader-platform-agent'
          GLOADER_PLATFORM_AWS_TAG_NAME_ID.must_equal 'gloader-platform-id'
        end
      end

      describe '#config' do
        it 'should return default config' do
          subject.config[:instance_size_agent].must_equal 'm1.medium'
          subject.config[:instance_size_console].must_equal 'm1.medium'
          subject.config[:aws_id].must_equal 'foo'
        end
      end

      describe '#rate_limit' do
        it 'should add a rate limiter for the iaas api' do
          subject.rate_limit
          SlowWeb.get_limit('amazonaws.com').host.must_equal 'amazonaws.com'
        end
        it 'should not add another rate limiter if one has already been set' do
          subject.rate_limit
          subject.rate_limit
          SlowWeb.get_limit('amazonaws.com').host.must_equal 'amazonaws.com'
        end
      end

      describe '#destroy' do
        it 'should destroy all keys and security groups even if none exist' do
          subject.destroy
        end
        it 'should destroy all keys and security groups' do
          subject.create_local_keys
          subject.create_security_groups
          subject.connection('eu-west-1').key_pairs.create({ name: 'fog_gloader_platform' })

          subject.connection('eu-west-1').key_pairs.select do |g|
            g.name == 'fog_gloader_platform'
          end.count.must_equal 1
          subject.connection('eu-west-1').security_groups.select do |g|
            g.name == 'gloader'
          end.count.must_equal 1

          subject.destroy

          subject.connection('eu-west-1').key_pairs.select do |g|
            g.name == 'fog_gloader_platform'
          end.count.must_equal 0
          subject.connection('eu-west-1').security_groups.select do |g|
            g.name == 'gloader'
          end.count.must_equal 0
        end
      end

      describe '#regions' do
        it 'should return a hash of Iaas regions' do
          subject.regions.length.must_equal 8
          subject.regions['eu-west-1'][:image_id].must_equal 'ami-ca1a14be'
          subject.regions.each_pair do |region, config|
            config[:image_id].must_match /^ami-[a-z0-9]+$/
            config[:weight].must_be_instance_of Fixnum
          end
        end
      end

      describe '#connection' do
        it 'should return a connection for a region' do
          subject.connection('eu-west-1').must_be_instance_of Fog::Compute::AWS::Mock
          subject.connection('eu-west-1').region.must_equal 'eu-west-1'
          subject.connection('us-east-1').region.must_equal 'us-east-1'
        end
        it 'will raise if region is empty' do
          assert_raises(ArgumentError) { subject.connection }
        end
      end

      describe '#connection_storage' do
        before(:each) do
          Fog.mock!
        end
        after(:each) do
          Fog::Mock.reset
        end
        it 'should return a S3 connection for a region' do
          subject.connection_storage.must_be_instance_of Fog::Storage::AWS::Mock
          subject.connection_storage.directories.must_be_instance_of Fog::Storage::AWS::Directories
          subject.connection_storage.directories.must_equal []
        end
      end

      describe '#find_instances_by_tag' do
        it 'will raise if region is not passed' do
          assert_raises(ArgumentError) { subject.find_instances_by_tag }
        end
        it 'will return no instances if there aren\'t any' do
          subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                        GLOADER_PLATFORM_AWS_AGENT_TAG).must_equal []
        end
        it 'will return agent instances based on tags' do
          create_console
          create_agent('eu-west-1')
          create_agent('us-east-1')
          create_other('us-east-1')
          servers = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_AGENT_TAG)
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
          servers = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_CONSOLE_TAG)
          servers.size.must_equal 1
          servers.first.must_be_instance_of Fog::Compute::AWS::Server
          servers.each do |server|
            server.tags['Name'].wont_equal 'Other Instance'
          end
        end
      end

      describe '#instance_image' do
        it 'will return an image id for a region' do
          subject.instance_image('eu-west-1').must_equal 'ami-ca1a14be'
        end
        it 'will raise for an invalid region' do
          assert_raises(ArgumentError) { subject.instance_image('foo') }
        end
      end

      describe '#instance_size' do
        it 'will return an image size for an instance type' do
          subject.instance_size(:agent).must_equal 'm1.medium'
          subject.instance_size(:console).must_equal 'm1.medium'
        end
        it 'will raise for an invalid instance type' do
          assert_raises(ArgumentError) { subject.instance_size('foo') }
        end
      end

      describe '#create_security_group' do
        it 'should create a security group' do
          subject.create_security_group('eu-west-1')
          group = subject.connection('eu-west-1').security_groups.select do |g|
            g.name == 'gloader'
          end.first
          group.must_be_instance_of Fog::Compute::AWS::SecurityGroup
          perms = group.ip_permissions
          perms.select { |p| p['ipProtocol'] == 'tcp' && p['toPort'] == 22 }.wont_be_empty
          perms.select { |p| p['ipProtocol'] == 'tcp' && p['toPort'] == 6372 }.wont_be_empty
          perms.select { |p| p['ipProtocol'] == 'tcp' && p['toPort'] == 6373 }.wont_be_empty
        end
      end

      describe '#destroy_security_group' do
        it 'should delete a security group even if it doesn\'t exist' do
          subject.destroy_security_group('eu-west-1').must_equal nil
        end
        it 'should delete a existing security group' do
          subject.create_security_group('eu-west-1')
          subject.destroy_security_group('eu-west-1').status.must_equal 200
        end
      end

      describe '#instance_tags' do
        it 'will return instance tags for a agent instance' do
          subject.instance_tags(:agent)[GLOADER_PLATFORM_AWS_TAG_NAME].must_equal \
            GLOADER_PLATFORM_AWS_AGENT_TAG
          subject.instance_tags(:agent)[GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
        end
        it 'will return instance tags for a console instance' do
          subject.instance_tags(:console)[GLOADER_PLATFORM_AWS_TAG_NAME].must_equal \
            GLOADER_PLATFORM_AWS_CONSOLE_TAG
          subject.instance_tags(:console)[GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
        end
      end

      describe '#platform_id' do
        it 'will return a platform id' do
          subject.platform_id.must_equal 'default'
        end
      end

      describe '#key_path' do
        it 'will return the path of a public key' do
          require_path = File.expand_path '.gloader_platform_public_test.key'
          subject.key_path(:public).must_equal require_path
        end
        it 'will return the path of a private key' do
          require_path = File.expand_path '.gloader_platform_private_test.key'
          subject.key_path(:private).must_equal require_path
        end
      end

      describe '#iaas_key_exists?' do
        it 'will return false if a key doesn\'t exist' do
          region = 'eu-west-1'
          subject.iaas_key_exists?(region).must_equal false
        end
        it 'will return true if a key already exists' do
          region = 'eu-west-1'
          subject.connection(region).key_pairs.create({ name: subject.key_name(true) })
          subject.iaas_key_exists?(region).must_equal true
        end
      end

      describe '#local_keys_exists?' do
        it 'will return false if a private key doesn\'t exist' do
          subject.local_keys_exists?.must_equal false
        end
        it 'will return true if a key already exists' do
          subject.create_local_keys
          subject.local_keys_exists?.must_equal true
        end
      end

      describe '#key_name' do
        it 'will return a key pair name withoug a prefix by default' do
          subject.key_name.must_equal 'gloader_platform'
        end
        it 'will return a key pair name with a prefix' do
          subject.key_name(true).must_equal 'fog_gloader_platform'
        end
      end

      describe '#instance_attributes' do
        it 'will return attributes for a console instance' do
          region = 'eu-west-1'
          type = :console
          attr = subject.instance_attributes(type, region)
          attr[:tags][GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
          attr[:tags][GLOADER_PLATFORM_AWS_TAG_NAME].must_equal GLOADER_PLATFORM_AWS_CONSOLE_TAG
          attr[:image_id].must_equal subject.regions[region][:image_id]
        end
        it 'will return attributes for an agent instance' do
          region = 'eu-west-1'
          type = :agent
          attr = subject.instance_attributes(type, region)
          attr[:tags][GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
          attr[:tags][GLOADER_PLATFORM_AWS_TAG_NAME].must_equal GLOADER_PLATFORM_AWS_AGENT_TAG
          attr[:image_id].must_equal subject.regions[region][:image_id]
        end
      end

      describe '#instance_tags' do
        it 'will return tags for a console instance' do
          type = :console
          tags = subject.instance_tags(type)
          tags[GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
          tags[GLOADER_PLATFORM_AWS_TAG_NAME].must_equal GLOADER_PLATFORM_AWS_CONSOLE_TAG
        end
        it 'will return tags for an agent instance' do
          type = :agent
          tags = subject.instance_tags(type)
          tags[GLOADER_PLATFORM_AWS_GROUP_TAG].must_equal 'true'
          tags[GLOADER_PLATFORM_AWS_TAG_NAME].must_equal GLOADER_PLATFORM_AWS_AGENT_TAG
        end
      end

      describe '#create_instance' do

        subject do
          aws_config = GLoader::Config.new
          aws_config.config(:default, { aws_id:       'foo',
                                        aws_key:      'bar',
                                        platform_id:  'default' })
          GLoader::Iaas::Aws.new(aws_config)
        end

        it 'will create an agent instance' do
          subject.create_instance(:agent, 'eu-west-1').must_be_instance_of Fog::Compute::AWS::Server
          servers = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_AGENT_TAG)
          servers.first.key_name.must_equal 'fog_gloader_platform'
        end
        it 'will create a console instance' do
          server = subject.create_instance(:console, 'eu-west-1')
          server.must_be_instance_of Fog::Compute::AWS::Server
          servers = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_CONSOLE_TAG)
          servers.size.must_equal 1
        end
        it 'will raise for an invalid instance type' do
          assert_raises(ArgumentError) { subject.create_instance('foo', 'eu-west-1') }
        end
        it 'will raise for an invalid region' do
          assert_raises(ArgumentError) { subject.create_instance(:agent, 'foo') }
        end
      end

      describe '#destroy_instances' do
        it 'will destroy instances even if not available' do
          subject.destroy_instances(:agent).must_equal []
        end
        def create_platform_instances
          create_console('eu-west-1')
          create_agent('eu-west-1')
          create_agent('us-east-1')
          create_other('us-east-1')
          console = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_CONSOLE_TAG)
          agents = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                 GLOADER_PLATFORM_AWS_AGENT_TAG)
          console.count.must_equal 1
          agents.count.must_equal 2
        end
        it 'will destroy console instances' do
          create_platform_instances
          subject.destroy_instances(:console)
          console = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_CONSOLE_TAG)
          agents = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                 GLOADER_PLATFORM_AWS_AGENT_TAG)
          agents.count.must_equal 2
          console.count.must_equal 0
        end
        it 'will destroy agent instances' do
          create_platform_instances
          subject.destroy_instances(:agent)
          console = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                  GLOADER_PLATFORM_AWS_CONSOLE_TAG)
          agents = subject.find_instances_by_tag(GLOADER_PLATFORM_AWS_TAG_NAME,
                                                 GLOADER_PLATFORM_AWS_AGENT_TAG)
          agents.count.must_equal 0
          console.count.must_equal 1
        end
        it 'will raise for an invalid instance type' do
          assert_raises(ArgumentError) { subject.destroy_instances('foo', 'eu-west-1') }
        end
        it 'will raise for an invalid region' do
          assert_raises(ArgumentError) { subject.destroy_instances(:agent, 'foo') }
        end
      end
    end
  end
end

# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do
  describe GLoader::Iaas do

    let(:gloader) do
      class Test
        include GLoader::Iaas
      end
      gloader = Test.new
      aws_config = GLoader::Config.new
      aws_config.config(:default, { aws_id:       'foo',
                                    aws_key:      'bar',
                                    platform_id:  'default' })

      gloader.provider(aws_config)
      gloader
    end

    before(:each) do
      Fog.mock!
      Fog::Mock.delay = 0
    end

    after(:each) do
      Fog::Mock.reset
      gloader.provider.destroy
    end

    def create_other(region)
      gloader.provider.connection(region).servers.create({
        image_id:           'ami-ca1a14be',
        flavor_id:          'm1.medium',
        tags: {
          'Name' => 'Other Instance'
        }
      })
    end

    describe '#provider' do
      it 'should return a IaaS provider' do
        gloader.provider.must_be_instance_of GLoader::Iaas::Aws
      end
    end

    describe '#status' do
      it 'should return a message if no servers were found' do
        out, _err = capture_io do
          gloader.get_status
        end
        out.must_match /No instances found/
      end
      it 'should return a summary of a plaform' do
        gloader.provider.create_instance(:console, 'eu-west-1')
        gloader.provider.create_instance(:agent, 'eu-west-1')
        gloader.provider.create_instance(:agent, 'us-east-1')
        create_other('us-east-1')
        out, _err = capture_io do
          gloader.get_status
        end
        out.must_match /Console\: i-[a-z0-9]+/
        out.must_match /\(ec2-[-0-9]+\.compute-1\.amazonaws.com - m1.medium\)/
        out.must_match /Agents\: i-[a-z0-9]+/
        out.must_match /\(e.g. ec2-[-0-9]+\.compute-1\.amazonaws.com - m1.medium\)/
      end
      it 'should return a summary of a plaform with no console' do
        gloader.provider.create_instance(:agent, 'eu-west-1')
        gloader.provider.create_instance(:agent, 'us-east-1')
        create_other('us-east-1')
        out, _err = capture_io do
          gloader.get_status
        end
        out.must_match /Console\: Not running/
        out.must_match /Total\: 2/
      end
      it 'should return a summary of a plaform with no agents' do
        gloader.provider.create_instance(:console, 'eu-west-1')
        create_other('us-east-1')
        out, _err = capture_io do
          gloader.get_status
        end
        out.must_match /Agents\: 0/
        out.must_match /Total\: 1/
      end
    end

    describe '#get_console_instance' do
      it 'should have a test' do
        skip
      end
    end

    describe '#get_agent_instances' do
      it 'should have a test' do
        skip
      end
    end

  end
end

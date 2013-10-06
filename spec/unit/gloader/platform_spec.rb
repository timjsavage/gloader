# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Platform do

    before(:each) do
      Fog.mock!
      Fog::Mock.delay = 0
    end

    after(:each) do
      Fog::Mock.reset
      subject.provider.destroy
    end

    subject do
      GLoader::Platform.new({ aws_access_key_id:      'foo',
                              aws_secret_access_key:  'bar',
                              platform_id:            'default',
                              region:                 'eu-west-1' })
    end

    describe '#status' do
      it 'should return a message if no servers were found' do
        out, _err = capture_io do
          subject.status
        end
        out.must_match /No instances found/
      end
    end

    describe '#create' do
      it 'should create a platform' do
        subject.create
        subject.provider.get_console_instance.size.must_equal 1
        subject.provider.get_agent_instances.size.must_equal 1
      end
    end

    describe '#create_console' do
      it 'should create a console instance if one doesn\'t exist' do
        subject.create_console
        subject.provider.get_console_instance.size.must_equal 1
      end
      it 'should not create a console instance if one exists' do
        subject.create_console
        subject.create_console
        subject.provider.get_console_instance.size.must_equal 1
      end
    end

    describe '#create_agents' do
      it 'should create an agent instance if one doesn\'t exists' do
        subject.create_agents
        subject.provider.get_agent_instances.size.must_equal 1
      end
    end

    describe '#destroy' do
      it 'should destroy a platform' do
        subject.create
        subject.provider.iaas_key_exists?('eu-west-1').must_equal true
        subject.provider.local_keys_exists?.must_equal true
        subject.provider.get_console_instance.size.must_equal 1
        subject.provider.get_agent_instances.size.must_equal 1
        subject.destroy
        subject.provider.get_console_instance.size.must_equal 0
        subject.provider.get_agent_instances.size.must_equal 0
        subject.provider.iaas_key_exists?('eu-west-1').must_equal false
        subject.provider.local_keys_exists?.must_equal false
      end
    end

    describe '#destroy_console' do
      it 'should destroy a console instance' do
        subject.create
        subject.destroy_console
        subject.provider.get_console_instance.size.must_equal 0
        subject.provider.get_agent_instances.size.must_equal 1
      end
    end

    describe '#destroy_agents' do
      it 'should destroy the agent instances' do
        subject.create
        subject.destroy_agents
        subject.provider.get_console_instance.size.must_equal 1
        subject.provider.get_agent_instances.size.must_equal 0
      end
    end

    describe '#deploy_scripts' do
      it 'should have a test' do
        skip
      end
    end
  end
end

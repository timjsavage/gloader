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
      gloader.provider.destroy
    end

    let(:gloader) do
      GLoader::Platform.new({ aws_access_key_id:      'foo',
                              aws_secret_access_key:  'bar',
                              platform_id:            'default' })
    end

    describe '#status' do
      it 'should return a message if no servers were found' do
        out, _err = capture_io do
          gloader.status
        end
        out.must_match /No instances found/
      end
    end

    describe '#create' do
      it 'should have a test' do
        skip
      end
    end

    describe '#create_console' do
      it 'should have a test' do
        skip
      end
    end

    describe '#create_agents' do
      it 'should have a test' do
        skip
      end
    end

    describe '#destroy' do
      it 'should have a test' do
        skip
      end
    end

    describe '#destroy_console' do
      it 'should have a test' do
        skip
      end
    end

    describe '#destroy_agents' do
      it 'should have a test' do
        skip
      end
    end

    describe '#deploy_scripts' do
      it 'should have a test' do
        skip
      end
    end
  end
end

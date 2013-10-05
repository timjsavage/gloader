# Encoding: utf-8

require_relative '../../spec_helper'

describe GLoader do
  describe GLoader::Iaas do
    describe GLoader::Iaas::Rackspace do

      before(:each) do
        Fog.mock!
        Fog::Mock.delay = 0
      end

      after(:each) do
        Fog::Mock.reset
        gloader.destroy
      end

      let(:gloader) do
        GLoader::Iaas::Rackspace.new({ rackspace_username:     'foo2',
                                       rackspace_api_key:      'bar2',
                                       platform_id:            'default',
                                       init:                   false })
      end

      describe '#config' do
        it 'should return default config' do
          gloader.config[:instance_size_agent].must_equal '4'
          gloader.config[:instance_size_console].must_equal '4'
          gloader.config[:rackspace_username].must_equal 'foo2'
        end
      end

      describe '#rate_limit' do
        it 'should add a rate limiter for the iaas api' do
          gloader.rate_limit
          SlowWeb.get_limit('rackspacecloud.com').host.must_equal 'rackspacecloud.com'
        end
        it 'should not add another rate limiter if one has already been set' do
          gloader.rate_limit
          gloader.rate_limit
          SlowWeb.get_limit('rackspacecloud.com').host.must_equal 'rackspacecloud.com'
        end
      end

      describe '#connection' do
        it 'should return a connection for a region' do
          gloader.connection.must_be_instance_of Fog::Compute::RackspaceV2::Mock
        end
      end

      describe '#connection_storage' do
        it 'should return a storage connection' do
          gloader.connection_storage.must_be_instance_of Fog::Storage::Rackspace::Mock
          directories = gloader.connection_storage.directories
          directories.must_be_instance_of Fog::Storage::Rackspace::Directories
          directories.must_equal []
        end
      end
    end
  end
end

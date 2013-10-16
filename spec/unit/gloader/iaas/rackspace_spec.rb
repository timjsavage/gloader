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
        subject.destroy_dependencies
      end

      subject do
        GLoader::Iaas::Rackspace.new(rackspace_id:  'foo2',
                                     rackspace_key: 'bar2',
                                     platform_id:   'default',
                                     init:          false)
      end

      describe '#config' do
        it 'should return default config' do
          subject.config[:instance_size_agent].must_equal '4'
          subject.config[:instance_size_console].must_equal '4'
          subject.config[:rackspace_id].must_equal 'foo2'
        end
      end

      describe '#rate_limit' do
        it 'should add a rate limiter for the iaas api' do
          subject.rate_limit
          SlowWeb.get_limit('rackspacecloud.com').host.must_equal 'rackspacecloud.com'
        end
        it 'should not add another rate limiter if one has already been set' do
          subject.rate_limit
          subject.rate_limit
          SlowWeb.get_limit('rackspacecloud.com').host.must_equal 'rackspacecloud.com'
        end
      end

      describe '#connection' do
        it 'should return a connection for a region' do
          subject.connection(:lon).must_be_instance_of Fog::Compute::RackspaceV2::Mock
          subject.connection(:ord).must_be_instance_of Fog::Compute::RackspaceV2::Mock
          subject.connection(:ord).must_be_instance_of Fog::Compute::RackspaceV2::Mock
        end
        it 'will raise if region is empty' do
          assert_raises(ArgumentError) { subject.connection }
        end
      end

      describe '#connection_storage' do
        it 'should return a storage connection' do
          subject.connection_storage.must_be_instance_of Fog::Storage::Rackspace::Mock
          directories = subject.connection_storage.directories
          directories.must_be_instance_of Fog::Storage::Rackspace::Directories
          directories.must_equal []
        end
      end
    end
  end
end

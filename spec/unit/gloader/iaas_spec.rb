# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do
  describe GLoader::Iaas do

    let(:gloader) do
      class Test
        include GLoader::Iaas
      end.new
    end

    describe '#constants' do
      it 'should have tag constants set' do
        LOAD_TEST_PLATFORM_GROUP_TAG.must_equal 'gloader-platform'
        LOAD_TEST_PLATFORM_TAG_NAME.must_equal 'gloader-platform-type'
        LOAD_TEST_PLATFORM_CONSOLE_TAG.must_equal 'gloader-platform-console'
        LOAD_TEST_PLATFORM_AGENT_TAG.must_equal 'gloader-platform-agent'
        LOAD_TEST_PLATFORM_TAG_NAME_ID.must_equal 'gloader-platform-id'
      end
    end

    describe '#provider' do
      it 'should return a IaaS provider' do
        gloader.provider.must_be_instance_of GLoader::Iaas::Aws
      end
    end
  end
end

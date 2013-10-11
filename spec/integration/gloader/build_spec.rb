# Encoding: utf-8

require_relative '../spec_helper'

describe 'GLoader CLI' do
  describe 'Build' do

    before(:each) do
      Fog.mock!
      Fog::Mock.delay = 0

      aws_config = GLoader::Config.new
      aws_config.config(:default,
                        { aws_id:      'foo',
                          aws_key:     'bar',
                          platform_id: 'default' },
                        true)
    end

    after(:each) do
      Fog::Mock.reset
    end

    describe 'status' do
      it 'should show help for the build command' do
        out, _err = capture_io do
          GLoader::CLI.start(%w[help build])
        end
        out.must_match /gloader build SUBCOMMAND ...ARGS/
        out.must_match /Build a load test platform/
      end
    end

  end
end

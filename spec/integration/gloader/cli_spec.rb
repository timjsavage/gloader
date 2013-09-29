# Encoding: utf-8

require_relative '../spec_helper'

describe 'GLoader CLI' do

  before(:each) do
    Fog.mock!
    Fog::Mock.delay = 0
  end

  after(:each) do
    Fog::Mock.reset
  end

  describe 'Main commands' do

    it 'should show help if no command given' do
      out, _err = capture_io do
        GLoader::CLI.start
      end
      out.must_match /gloader build SUBCOMMAND ...ARGS  \# Build a load test platform/
      out.must_match /gloader test SUBCOMMAND ...ARGS   \# Run a load test/
    end
    it 'should show help for the build command' do
      out, _err = capture_io do
        GLoader::CLI.start(['build'])
      end
        out.must_match /gloader build create/
    end
    it 'should show help for the test command' do
      out, _err = capture_io do
        GLoader::CLI.start(['test'])
      end
      out.must_match /gloader test finish/
    end

  end
end

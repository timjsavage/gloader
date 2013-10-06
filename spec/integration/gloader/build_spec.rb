# Encoding: utf-8

require_relative '../spec_helper'

describe 'GLoader CLI' do
  describe 'Build' do

    before(:each) do
      Fog.mock!
      Fog::Mock.delay = 0
    end

    after(:each) do
      Fog::Mock.reset
    end

    describe 'status' do
      it 'should show help for the build command' do
        skip('Need to add method of passing default config')
        out, _err = capture_io do
          GLoader::CLI.start(%w[build status])
        end
        out.must_match /gloader build create/
      end
    end
  end
end

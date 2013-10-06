# Encoding: utf-8

require_relative '../spec_helper'

describe 'GLoader CLI' do
  describe 'GLoader Test' do

    before(:each) do
      Fog.mock!
      Fog::Mock.delay = 0
    end

    after(:each) do
      Fog::Mock.reset
    end

  end
end

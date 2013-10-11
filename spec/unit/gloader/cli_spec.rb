# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do
  describe GLoader::CLI do

    subject do
      GLoader::Config.new
    end

    before(:each) do
      GLoader::CLI.start
    end

    after(:each) do
    end

  end
end

# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Console do

    let(:gloader) { GLoader::Console.new }

    describe '#console_url' do
      it 'should return a console url' do
        gloader.console_url.must_equal 'http://gloader.bendodd.com:6373'
      end
    end

    describe '#console_host' do
      it 'should return a console host' do
        gloader.console_host.must_equal 'gloader.bendodd.com'
      end
    end

    describe '#console_port' do
      it 'should return a console port' do
        gloader.console_port.must_equal 6373
      end
    end

  end
end

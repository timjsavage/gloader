# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Platform do

    let(:gloader) { GLoader::Platform.new }

    describe '#status' do
      it 'should return a message if no servers were found' do
        out, _err = capture_io do
          gloader.status
        end
        out.must_match /No instances found/
      end
    end
  end
end

# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Core do

    subject do
      class Test
        include GLoader::Core
      end.new
    end

    describe '#output' do
      it 'should output' do
        out, _err = capture_io do
          subject.output do
            Formatador.display_line('Hello')
          end
        end
        out.must_match /Hello/
      end
    end
  end
end

# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Config do

    let(:gloader) { GLoader::Config.new }

    describe '#parse_config' do
      it 'should return an empy hash if no config file exists' do
        gloader.parse_config.must_equal Hash.new
      end
      it 'should return an hash if a config exists' do
        gloader.singleton_class.class_eval do
          def config_path
            File.expand_path 'spec/unit/fixtures/config_gloader.yml'
          end
        end
        config_hash = { 'platform_id' => 'default' }
        gloader.parse_config.must_equal config_hash
      end
    end

    describe '#save_default_config' do
      it 'should save the default config to disk' do
        gloader.singleton_class.class_eval do
          def config_path
            File.expand_path 'spec/unit/fixtures/config_gloader_temp.yml'
          end
        end
        config_hash = { 'platform_id' => 'default' }
        gloader.save_default_config
        YAML.load_file(gloader.config_path).must_equal config_hash
        File.delete gloader.config_path
      end
    end
  end
end

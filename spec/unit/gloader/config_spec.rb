# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Config do

    let(:gloader) { GLoader::Config.new }

    before(:each) do
      default_path = File.expand_path('spec/unit/fixtures/config_gloader_default.yml')
      state_path = File.expand_path('spec/unit/fixtures/config_gloader_state.yml')
      unless gloader.config_path(:default) == default_path
        File.delete gloader.config_path(:default) if File.exists?(gloader.config_path(:default))
      end
      unless gloader.config_path(:state) == state_path
        File.delete gloader.config_path(:state) if File.exists?(gloader.config_path(:state))
      end
    end

    after(:each) do
      default_path = File.expand_path('spec/unit/fixtures/config_gloader_default.yml')
      state_path = File.expand_path('spec/unit/fixtures/config_gloader_state.yml')
      unless gloader.config_path(:default) == default_path
        File.delete gloader.config_path(:default) if File.exists?(gloader.config_path(:default))
      end
      unless gloader.config_path(:state) == state_path
        File.delete gloader.config_path(:state) if File.exists?(gloader.config_path(:state))
      end
    end

    describe '#initialize' do
      it 'should return an empy hash if no config file exists' do
        gloader.config(:default).must_equal Hash.new
        gloader.config(:state).must_equal Hash.new
      end
      it 'should return a hash if default config file exists' do
        skip # need to work out how to override the config_path before initialing
      end
      it 'should return a hash if state config file exists' do
        skip # need to work out how to override the config_path before initialing
      end
    end

    describe '#config' do
      it 'should return an empy hash if no config file exists' do
        gloader.config(:default).must_equal Hash.new
        gloader.config(:state).must_equal Hash.new
      end
      it 'should allow the default config to be updated' do
        FileUtils.cp File.expand_path('spec/unit/fixtures/config_gloader_default.yml'),
                     File.expand_path('spec/unit/fixtures/config_gloader_default_temp.yml')
        gloader.singleton_class.class_eval do
          def config_path(type)
            File.expand_path 'spec/unit/fixtures/config_gloader_default_temp.yml'
          end
        end
        default = { 'platform_id' => 'default' }
        default_new = { 'platform_id' => 'default', 'iaas' => 'aws' }
        gloader.parse_config(:default)
        gloader.config(:default).must_equal default
        gloader.config(:default, default_new, true).must_equal default_new
        gloader.config(:default).must_equal default_new
      end
      it 'should allow the state config to be updated' do
        FileUtils.cp File.expand_path('spec/unit/fixtures/config_gloader_state.yml'),
                     File.expand_path('spec/unit/fixtures/config_gloader_state_temp.yml')
        gloader.singleton_class.class_eval do
          def config_path(type)
            File.expand_path 'spec/unit/fixtures/config_gloader_state_temp.yml'
          end
        end
        state     = { 'platform_id' => 'megaload-us',
                      'test' => {
                        'current' => 'load_test_2013_10_04_14_28_55_UTC_Friday'
                      }
                    }
        state_new = { 'platform_id' => 'megaload-us',
                      'test' => {
                        'current' => 'load_test_2013_10_04_17_00_00_UTC_Friday'
                      }
                    }
        gloader.parse_config(:state)
        gloader.config(:state).must_equal state
        gloader.config(:state, state_new, true).must_equal state_new
        gloader.config(:state).must_equal state_new
      end
    end

    describe '#parse_config' do
      it 'should return an empy hash if no config file exists' do
        gloader.parse_config(:default).must_equal Hash.new
        gloader.parse_config(:state).must_equal Hash.new
      end
      it 'should return an hash if a default config exists' do
        gloader.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}.yml"
          end
        end
        default = { 'platform_id' => 'default' }
        state   = { 'platform_id' => 'megaload-us',
                    'test' => {
                      'current' => 'load_test_2013_10_04_14_28_55_UTC_Friday'
                    }
                  }
        gloader.parse_config(:default).must_equal default
        gloader.parse_config(:state).must_equal state
      end
    end

    describe '#save_default_config' do
      it 'should save the default config to disk' do
        gloader.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}_temp.yml"
          end
        end
        config_hash = { 'platform_id' => 'default' }
        gloader.save_default_config
        YAML.load_file(gloader.config_path(:default)).must_equal config_hash
        File.delete gloader.config_path(:default)
      end
    end
  end
end

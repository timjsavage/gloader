# Encoding: utf-8

require_relative '../spec_helper'

describe GLoader do

  describe GLoader::Config do

    subject do
      GLoader::Config.new
    end

    def remove_config_files
      default_path = File.expand_path('spec/unit/fixtures/config_gloader_default.yml')
      state_path = File.expand_path('spec/unit/fixtures/config_gloader_state.yml')
      unless subject.config_path(:default) == default_path
        File.delete subject.config_path(:default) if File.exists?(subject.config_path(:default))
      end
      unless subject.config_path(:state) == state_path
        File.delete subject.config_path(:state) if File.exists?(subject.config_path(:state))
      end
    end

    before(:each) do
      remove_config_files
    end

    after(:each) do
      remove_config_files
    end

    describe '#initialize' do
      it 'should return an empy hash if no config file exists' do
        empty_config = { default: {}, state: {} }
        subject.config.must_equal empty_config
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
        empty_config = { default: {}, state: {} }
        subject.config.must_equal empty_config
      end
      it 'should allow the default config to be updated' do
        FileUtils.cp File.expand_path('spec/unit/fixtures/config_gloader_default.yml'),
                     File.expand_path('spec/unit/fixtures/config_gloader_default_temp.yml')
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path 'spec/unit/fixtures/config_gloader_default_temp.yml'
          end
        end
        default = { default: { platform_id: 'default' }, state: {} }
        default_new = { default: { platform_id: 'default', iaas: 'aws' }, state: {} }
        subject.parse_config(:default)
        subject.config.must_equal default
        subject.config(:default, { platform_id: 'default', iaas: 'aws' }, true)
        subject.config(:default).must_equal default_new
      end
      it 'should allow the state config to be updated' do
        FileUtils.cp File.expand_path('spec/unit/fixtures/config_gloader_state.yml'),
                     File.expand_path('spec/unit/fixtures/config_gloader_state_temp.yml')
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path 'spec/unit/fixtures/config_gloader_state_temp.yml'
          end
        end
        state     = { platform_id: 'megaload-us',
                      test: {
                        current: 'load_test_2013_10_04_14_28_55_UTC_Friday'
                      }
                    }
        to_merge  = { platform_id: 'megaload-us',
                      test: {
                        current: 'load_test_2013_10_04_17_00_00_UTC_Friday'
                      }
                    }

        state = { default: {}, state: state }
        state_new = { default: {}, state: to_merge }

        subject.parse_config(:state)
        subject.config(:state).must_equal state
        subject.config(:state, to_merge, true).must_equal state_new
        subject.config(:state).must_equal state_new
      end
    end

    describe '#parse_config' do
      it 'should return an empy hash if no config file exists' do
        empty_config = { default: {}, state: {} }
        subject.parse_config(:default).must_equal empty_config
        subject.parse_config(:state).must_equal empty_config
      end
      it 'should return an hash if a default config exists' do
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}.yml"
          end
        end

        parsed_config = { default: { platform_id: 'default' },
                          state: {
                            platform_id: 'megaload-us',
                            test: {
                              current: 'load_test_2013_10_04_14_28_55_UTC_Friday'
                            }
                          }
                        }
        subject.parse_config(:default)
        subject.parse_config(:state)
        subject.config.must_equal parsed_config
      end
    end

    describe '#save_default_config' do
      it 'should save the default config to disk' do
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}_temp.yml"
          end
        end
        config_hash = { 'platform_id' => 'default' }
        subject.save_default_config
        YAML.load_file(subject.config_path(:default)).must_equal config_hash
        File.delete subject.config_path(:default)
      end
    end

    describe '#display' do
      it 'should display the default config' do
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}.yml"
          end
        end
        subject.parse_config(:default)
        out, _err = capture_io do
          subject.display
        end
        out.must_match /platform_id | default/
      end
      it 'should display the current config' do
        subject.singleton_class.class_eval do
          def config_path(type)
            File.expand_path "spec/unit/fixtures/config_gloader_#{type.to_s}.yml"
          end
        end
        subject.parse_config(:default)
        subject.parse_config(:state)
        out, _err = capture_io do
          subject.display
        end
        out.must_match /platform_id | megaload-us/
      end
    end
  end
end

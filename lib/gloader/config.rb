# Encoding: utf-8

require 'psych'
require 'active_support/core_ext/hash'

module GLoader
  class Config

    def initialize
      parse_config(:default)
      parse_config(:state)
    end

    def config(type = nil, config = {}, update = false)
      @config ||= { default: {}, state: {} }
      @config[type].deep_merge!(deep_symbolize_keys(config)) unless type.nil?
      update_config(type, @config[type]) if update
      deep_symbolize_keys(@config)
    end

    def combined
      @config[:default].deep_merge(@config[:state])
    end

    def deep_symbolize_keys(hash)
      hash.reduce({}) do |result, (key, value)|
        value = deep_symbolize_keys(value) if value.is_a? Hash
        result[(key.to_sym rescue key) || key] = value
        result
      end
    end

    def parse_config(type)
      config(type, Psych.load_file(config_path(type)), false) if File.exists?(config_path(type))
      config
    end

    def update_config(type, config)
      File.open(config_path(type), 'w+') { |f| f.write(config.to_yaml) }
    end

    def save_default_config
      File.open(config_path(:default), 'w+') { |f| f.write(default_config.to_yaml) }
    end

    def default_config
      { 'platform_id' => 'default' }
    end

    def config_path(type)
      path = File.expand_path ".gloader-#{type.to_s}.yml"
      path.sub!('.yml', '-test.yml') if ENV['GEM_ENV'] == 'test'
      path
    end

    def display
      table_data = []
      combined.each do |key, value|
        table_data << { key: key, value: value }
      end
      Formatador.display_compact_table(table_data)
    end
  end
end

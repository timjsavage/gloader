# Encoding: utf-8

require 'psych'

module GLoader
  class Config

    def initialize
      parse_config(:default)
      parse_config(:state)
    end

    def config(type, config = {}, update = false)
      @config ||= {}
      @config[type] ||= {}
      @config[type].merge!(config)
      update_config(type, config) if update
      @config[type]
    end

    def parse_config(type)
      config(type, Psych.load_file(config_path(type)), false) if File.exists?(config_path(type))
      config(type)
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
  end
end

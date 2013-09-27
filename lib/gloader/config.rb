# Encoding: utf-8

require 'psych'

module GLoader
  class Config

    def initialize
      parse_config
    end

    def config(config = {})
      @config ||= {}
      @config.merge!(config)
    end

    def parse_config
      config(Psych.load_file(config_path)) if File.exists?(config_path)
      config
    end

    def save_default_config
      File.open(config_path, 'w+') { |f| f.write(default_config.to_yaml) }
    end

    def default_config
      { 'platform_id' => 'default' }
    end

    def config_path
      File.expand_path '.gloader.yml'
    end
  end
end

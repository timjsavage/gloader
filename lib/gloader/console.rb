# Encoding: utf-8

require 'httparty'
require 'yajl'

module GLoader
  module Console

    include GLoader::Logger

    def console_url
      sprintf 'http://%s:%d', console_host, console_port
    end

    def console_host
      'gloader.bendodd.com'
    end

    def console_port
      6373
    end

    def make_console_api_request(method, resource, options = {})
      logger.info "Request: #{method} #{console_url}#{resource}"
      response = HTTParty.send(method.to_sym, console_url + '/' + resource, options)
      Yajl::Parser.parse(response.body, symbolize_keys: true)
    end
  end
end

# Encoding: utf-8

require_relative 'logger'
require_relative 'config'

module GLoader

  ##
  # Core functionality

  module Core

    def output(level = nil)
      yield if block_given?
    end
  end
end

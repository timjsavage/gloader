# Encoding: utf-8

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/pkg/'
  add_filter '/chef/'
  add_filter '/grinder/'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require_relative '../../lib/gloader/core'
require_relative '../../lib/gloader/config'
require_relative '../../lib/gloader/console'
require_relative '../../lib/gloader/cli'
require_relative '../../lib/gloader/iaas'

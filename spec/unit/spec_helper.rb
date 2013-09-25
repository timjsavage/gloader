# Encoding: utf-8

require 'simplecov'

SimpleCov.minimum_coverage 90
SimpleCov.refuse_coverage_drop
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start do
  add_filter '/spec/'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require_relative '../../lib/gloader/core'
require_relative '../../lib/gloader/console'
require_relative '../../lib/gloader/cli'
require_relative '../../lib/gloader/iaas'

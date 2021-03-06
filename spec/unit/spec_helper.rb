# Encoding: utf-8

ENV['GEM_ENV'] = 'test'

require_relative '../specs_helper'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
  maximum_coverage_drop 5
  command_name 'test:units'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require_relative '../../lib/gloader/logger'
require_relative '../../lib/gloader/core'
require_relative '../../lib/gloader/config'
require_relative '../../lib/gloader/console'
require_relative '../../lib/gloader/chef'
require_relative '../../lib/gloader/cli'
require_relative '../../lib/gloader/iaas'
require_relative '../../lib/gloader/platform'
require_relative '../../lib/gloader/test_run'

# Encoding: utf-8

ENV['GEM_ENV'] = 'test'

require_relative '../specs_helper'
require 'simplecov'
require 'simplecov-rcov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter
]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 60
  maximum_coverage_drop 5
  command_name 'test:integration'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'gloader'))

# Force Thor to raise exceptions so we can exit non-zero.
ENV['THOR_DEBUG'] = '1'

# Force the name of the script to 'gloader'
$0 = 'gloader'

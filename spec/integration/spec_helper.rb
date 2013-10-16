# Encoding: utf-8

ENV['GEM_ENV'] = 'test'

require_relative '../specs_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'gloader'))

# Force Thor to raise exceptions so we can exit non-zero.
ENV['THOR_DEBUG'] = '1'

# Force the name of the script to 'gloader'
$0 = 'gloader'

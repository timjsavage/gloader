# Encoding: utf-8

require 'simplecov'
SimpleCov.start

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'webmock/minitest'

require_relative '../../lib/gloader/core'
require_relative '../../lib/gloader/cli'

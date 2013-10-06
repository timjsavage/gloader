# Encoding: utf-8

require_relative 'gloader/core'
require_relative 'gloader/cli'
require_relative 'gloader/test_run'
require_relative 'gloader/platform'

# REMOVE after dev!
Fog.mock!
Fog::Mock.delay = 0

# Encoding: utf-8

require 'log4r'

module GLoader
  module Logger

    include Log4r

    OUTPUTTERS = {
      stdout: Log4r::StdoutOutputter.new(
        'console',
        formatter: Log4r::PatternFormatter.new(pattern: '%d %l [%c] %m')
      )
    }

    class << self

      def logging_level
        Log4r::DEBUG
      end

      def configure(mod)
        logger = Log4r::Logger.new(mod.name)
        logger.outputters = outputter_level
        logger.level = logging_level
        logger
      end

      def outputter_level
        [OUTPUTTERS[:stdout]] unless ENV['GEM_ENV'] == 'test'
      end

      # We use :define_method approach as well so that we can provide
      # a logger to classes that include a module that includes Logger.
      def included(mod)
        configure(mod)
        mod.send(:include, InstanceMethods)
        mod.extend(ClassMethods)
        mod.send :define_method, :logger do
          Log4r::Logger[mod.name]
        end
      end

    end

    module ClassMethods
      def logger
        Log4r::Logger[name]
      end
    end

    module InstanceMethods
      def logger
        self.class.logger
      end
    end
  end
end

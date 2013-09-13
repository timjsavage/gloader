require 'thor'

module GLoader
  class CLI < Thor
    include Thor::Actions

    def self.start(*)
      super
    rescue Exception => e
      raise e
    end

  end
end

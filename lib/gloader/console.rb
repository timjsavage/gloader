# Encoding: utf-8

module GLoader

  class Console

    def console_url
      sprintf 'http://%s:%d', console_host, console_port
    end

    def console_host
      'gloader.bendodd.com'
    end

    def console_port
      6373
    end
  end
end

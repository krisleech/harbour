require "harbour/version"

module Harbour
  class Port
    attr_reader :port

    def initialize(port)
      @port = port
    end

    def open?
      command "nc -z localhost #{port}"
    end

    def pid
      return nil unless open?
      if os? :mac
        `lsof -P | grep ':#{port}' | grep 'LISTEN' | awk '{print $2}'`
      else
        `fuser -k #{port}/tcp`
      end
    end

    def term!(options = {})
      return nil unless open?
      command "kill #{pid}"
      ensure_open(options[:timeout] || 10)
    end

    def kill!(options = {})
      return nil unless open?
      command "kill -9 #{pid}"
      ensure_open(options[:timeout] || 10)
    end

    private

    def ensure_open(within = 10)
      within.times do
        break if open?
        sleep(1)
      end
    end

    def os?(os)
      _os = { :mac => :darwin } || os
      RUBY_PLATFORM.include?(_os.to_s)
    end

    def command(_command)
      system "#{_command} > /dev/null"
    end
  end
end

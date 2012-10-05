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
      `lsof -P | grep '#{port}' | grep 'listen' | ack '{print $2}'`
    end

    def term!(options = {})

    end

    def kill!(options = {})

    end

    def self.all_open
      
    end

    private

    def command(_command)
      system "#{_command} > /dev/null"
    end
  end
end

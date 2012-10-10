require "harbour/version"

module Harbour
  class Port
    attr_reader :port

    class PortFailedToClose < StandardError; end

    def initialize(port)
      @port = port
    end

    def open?
      command "nc -z localhost #{port}"
    end

    def closed?
      !open?
    end

    def pid
      return nil unless open?
      `lsof -P | grep ':#{port}' | grep 'LISTEN' | awk '{print $2}'`.to_i
    end

    def term!(options = {})
      return nil unless open?
      Process.kill('TERM', pid)
      ensure_closed!(options[:timeout] || 10)
    rescue PortFailedToClose
      raise unless options[:try_kill] == true
      kill!(options)
    end

    def kill!(options = {})
      return nil unless open?
      Process.kill('KILL', pid)
      ensure_closed!(options[:timeout] || 10)
    end

    private

    def ensure_closed!(within = 10, step = 1)
      _elasped = within
      within.times do
        break if closed?
        sleep(step)
        _elasped = _elasped - step
      end
      raise PortFailedToClose, "Port #{port} did not close within #{within} seconds" if _elasped < 1
    end

    def command(_command)
      system "#{_command} > /dev/null"
    end
  end
end

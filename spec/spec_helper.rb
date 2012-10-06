require 'harbour'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

def with_server(port = '8000', &block)
  start_server!(port)
  yield
  stop_server!(port)
end

def start_server!(port)
  return if system "nc -z localhost #{port}"
  server_root = File.join(File.dirname(__FILE__), 'server')
  system "cd #{server_root} && rackup -d -p #{port} &"
  sleep(2)
end

def stop_server!(port)
  pid = `lsof -P | grep ':#{port}' | grep 'LISTEN' | awk '{print $2}'`
  system "kill -9 #{pid}"
end

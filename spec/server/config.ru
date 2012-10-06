require 'rack'

app = proc do |env|
    [200, { 'Content-Type' => 'text/html' }, 'Hello world!']
end

run app

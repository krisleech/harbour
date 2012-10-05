# Harbour

With harbour you can:

* See if a port is open
* Find the pid of the process listening on a port
* Kill the process listening on a port

## Installation

Add this line to your application's Gemfile:

    gem 'harbour'

## Usage

    port = Harbour::Port.new(8080)
    port.open? # => true
    port.pid   # => 1282
    port.term!
    port.kill!

### Terminating a process

    port = Harbour::Port.new(8080)
    port.term!(:timeout => 10, :try_kill => true)

* `timeout` - the number of seconds to wait for the process to terminate before
  raising an exception
* `try_kill` - if a TERM signal fails before timeout then send a KILL signal

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Kris Leech / teamcoding.com

# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harbour/version'

Gem::Specification.new do |gem|
  gem.name          = "harbour"
  gem.version       = Harbour::VERSION
  gem.authors       = ["Kris Leech"]
  gem.email         = ["kris.leech@interkonect.com"]
  gem.description   = %q{Query and terminate processes listening on ports}
  gem.summary       = %q{Query and terminate processes listening on ports}
  gem.homepage      = "https://github.com/krisleech/harbour"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rack'
end

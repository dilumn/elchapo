# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elchapo/version"

Gem::Specification.new do |spec|
  spec.name          = "elchapo"
  spec.version       = Elchapo::VERSION
  spec.authors       = ["DilumN"]
  spec.email         = ["dilumnavanjana@gmail.com"]

  spec.summary       = %q{Ruby API for Ethereum Blockchain network}
  spec.description   = %q{This will enable your Ruby application to connect to Ethereum Blockchain}
  spec.homepage      = "http://dilumn.github.io"
  spec.license       = "MIT"

  spec.files = %w(LICENSE.txt README.md elchapo.gemspec) + Dir['bin/*'] + Dir['lib/**/*.rb']
  spec.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

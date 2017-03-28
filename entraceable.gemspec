# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'entraceable/version'

Gem::Specification.new do |spec|
  spec.name          = "entraceable"
  spec.version       = Entraceable::VERSION
  spec.authors       = ["Keiji Yoshida"]

  spec.summary       = %q{Make your methods garrulous.}
  spec.description   = %q{Make your methods puts their actual arguments and return value using Rails logger.}
  spec.homepage      = "https://github.com/kei-g/entraceable"
  spec.license       = "3-Clause BSD"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

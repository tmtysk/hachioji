# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hachioji/version'

Gem::Specification.new do |spec|
  spec.name          = "hachioji"
  spec.version       = Hachioji::VERSION
  spec.authors       = ["tmtysk"]
  spec.email         = ["tmtysk@gmail.com"]
  spec.description   = %q{Utilities for programmers in Hachioji}
  spec.summary       = %q{Utilities for programmers in Hachioji}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.bindir             = 'bin'
  spec.executables        = ['hachioji_pm25']

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

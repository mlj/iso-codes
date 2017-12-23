# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso_codes/version'

Gem::Specification.new do |spec|
  spec.name          = "iso-codes"
  spec.version       = ISOCodes::VERSION
  spec.authors       = ["Marius L. Jøhndal"]
  spec.email         = ["mariuslj@ifi.uio.no"]
  spec.summary       = %q{ISO language and script codes}
  spec.description   = %q{A database of ISO language codes and ISO script codes for Ruby.}
  spec.homepage      = "http://github.com/mlj/iso-codes"
  spec.license       = 'MIT'

  spec.files         = Dir["{bin,lib}/**/*"] + %w(README.md LICENSE.md CHANGELOG.md)
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'bundler', '~> 1.16'
end

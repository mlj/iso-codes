# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso_codes/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'bundler', '~> 1.0'
  s.authors = ["Marius L. Jøhndal"]
  s.description = %q{A database of ISO language codes and ISO script codes for Ruby.}
  s.summary = %q{ISO language and script codes}
  s.email = ['mariuslj (at) ifi [dot] uio (dot) no']
  s.files = %w(CHANGELOG.md README.md LICENSE.md Rakefile iso-codes.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("lib/**/*.tab.gz")
  s.files += Dir.glob("test/*")
  s.homepage = "http://github.com/mlj/iso-codes"
  s.licenses = ['MIT']
  s.name = "iso-codes"
  s.require_paths = ["lib"]
  s.required_rubygems_version = '>= 1.3.5'
  s.test_files += Dir.glob("test/*")
  s.version = ISOCodes::VERSION
end

# encoding: utf-8
begin
  require 'jeweler'

  Jeweler::Tasks.new do |p|
    p.name = "iso-codes"
    p.summary = "ISO language and script code support"
    p.description = "A database of ISO language and script codes."
    p.authors = ['Marius L. Jøhndal']
    p.email = "mariuslj (at) ifi [dot] uio (dot) no"
    p.homepage = "http://github.com/mlj/iso-codes"
    p.rubyforge_project = "iso-codes"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

namespace :doc do
  require 'yard'
  YARD::Rake::YardocTask.new do |task|
  task.files   = ['README.md', 'LICENSE.md', 'lib/**/*.rb']
  task.options = [
    '--output-dir', 'doc/yard',
    '--markup', 'markdown',
    ]
  end
end

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

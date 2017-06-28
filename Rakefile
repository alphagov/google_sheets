require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

Rake.add_rakelib 'lib/tasks'

# If you want to make this the default task
task default: :spec

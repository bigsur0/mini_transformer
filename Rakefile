require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs += %w{ lib spec }
  t.test_files = FileList['spec/*/*_spec.rb', 'spec/*_spec.rb']
  t.verbose = true
end

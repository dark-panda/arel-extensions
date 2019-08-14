# frozen_string_literal: true
# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

$LOAD_PATH.push File.expand_path(File.dirname(__FILE__), 'lib')

version = Arel::Extensions::VERSION

desc 'Test Arel Extensions'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.main = 'README.rdoc'
  t.title = "Arel Extensions #{version}"
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.rdoc', 'MIT-LICENSE', 'lib/**/*.rb')
end

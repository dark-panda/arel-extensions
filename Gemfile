# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'guard'
gem 'guard-minitest'
gem 'minitest'
gem 'minitest-reporters'
gem 'rake', '~> 10.0'
gem 'rdoc', '~> 3.12'
gem 'simplecov'

if File.exist?('Gemfile.local')
  instance_eval File.read('Gemfile.local')
end

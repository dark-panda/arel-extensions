# frozen_string_literal: true

$LOAD_PATH << File.dirname(__FILE__)
require 'simplecov'

SimpleCov.command_name('Unit Tests')
SimpleCov.start do
  add_filter '/test/'
end

require 'rubygems'
require 'minitest/autorun'
require 'minitest/reporters'
require 'support/fake_record'

require File.join(File.dirname(__FILE__), %w(.. lib arel-extensions))

puts "Ruby version #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} - #{RbConfig::CONFIG['RUBY_INSTALL_NAME']}"
puts "Arel Extensions version #{Arel::Extensions::VERSION}"
puts "Arel version #{Arel::VERSION}"

MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
Arel::Table.engine = FakeRecord::Base.new

class Object
  def must_be_like other
    gsub(/\s+/, ' ').strip.must_equal other.gsub(/\s+/, ' ').strip
  end
end

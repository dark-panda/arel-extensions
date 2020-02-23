# frozen_string_literal: true
# -*- encoding: utf-8 -*-

require File.expand_path('../lib/arel/extensions/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "arel-extensions"
  s.version = Arel::Extensions::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["J Smith"]
  s.description = "Arel Extensions for various SQL constructs."
  s.summary = s.description
  s.email = "dark.panda@gmail.com"
  s.license = "MIT"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = "https://github.com/dark-panda/arel-extensions"
  s.require_paths = ["lib"]

  s.add_dependency("activerecord", ["~> 6.0"])
end

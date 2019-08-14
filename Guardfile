# frozen_string_literal: true

guard 'minitest', test_folders: 'test', test_file_patterns: 'test_*.rb' do
  watch(%r|^test/.+/(test_.+\.rb)|)

  watch(%r|^lib/(.+\.rb)|) do |m|
    dir, file = File.split(m[1])
    "test/#{dir}/test_#{file}"
  end

  watch(%r|^test/test_helper\.rb|) do
    'test'
  end
end

if File.exist?('Guardfile.local')
  instance_eval File.read('Guardfile.local')
end

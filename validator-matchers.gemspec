# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'validator/matchers/version'

version  = Validator::Matchers::VERSION::STRING
gem_name = 'validator-matchers'
repo_url = "https://github.com/athix/#{gem_name}"

Gem::Specification.new do |s|
  s.version     = version
  s.platform    = Gem::Platform::RUBY
  s.name        = gem_name
  s.summary     = 'RSpec matchers for your custom validator unit testing'
  # TODO: More descriptive description.
  # s.description = 'RSpec matchers for your custom validator unit testing'

  s.required_ruby_version = '>= 2.5.0'

  s.license  = 'MIT'
  s.author   = 'Josh Buker'
  s.email    = 'crypto@joshbuker.com'
  s.homepage = repo_url
  s.metadata = {
    'bug_tracker_uri' => "#{repo_url}/issues",
    'changelog_uri' => "#{repo_url}/releases/tag/v#{version}",
    'documentation_uri' => "https://rubydoc.info/gems/#{gem_name}",
    'source_code_uri' => "#{repo_url}/tree/v#{version}"
  }

  s.files      = `git ls-files -z`.split("\x0")
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.require_paths = ['lib']

  s.add_dependency 'rspec-rails', '>= 3.0', '< 7'
end

# frozen_string_literal: true

require_relative 'lib/solidus_jwt/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_jwt'
  s.version     = SolidusJwt::VERSION
  s.summary     = 'Add Json Web Tokens to Solidus API'
  s.description = 'Add Json Web Tokens to Solidus API'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Taylor Scott'
  s.email     = 't.skukx@gmail.com'
  s.homepage  = 'https://github.com/solidusio-contrib/solidus_jwt'

  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = s.homepage

  s.required_ruby_version = Gem::Requirement.new('>= 3.0.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  s.files = files.grep_v(%r{^(test|spec|features)/})
  s.test_files = files.grep(%r{^(test|spec|features)/})
  s.bindir = "exe"
  s.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'jwt'
  s.add_dependency 'solidus_auth_devise'
  s.add_dependency 'solidus_core', ['>= 2.0.0', '< 5']
  s.add_dependency 'solidus_support'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'solidus_dev_support'
end

$:.push File.expand_path('lib', __dir__)
require 'solidus_jwt/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_jwt'
  s.version     = SolidusJwt.version
  s.summary     = 'Add Json Web Tokens to Solidus API'
  s.description = 'Add Json Web Tokens to Solidus API'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Taylor Scott'
  s.email     = 't.skukx@gmail.com'
  s.homepage  = 'https://github.com/skukx'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'jwt'
  s.add_dependency 'solidus_auth_devise'
  s.add_dependency 'solidus_api', ['>= 1.0', '< 3']
  s.add_dependency 'solidus_core', ['>= 1.0', '< 3']
  s.add_dependency 'solidus_support', '>= 0.1.3'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end

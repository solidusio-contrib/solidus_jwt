require 'spree/core'

module SolidusJwt
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions::Decorators
    
    isolate_namespace ::Spree

    engine_name 'solidus_jwt'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end

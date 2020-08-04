module SolidusJwt
  module Deprecator
    def deprecator
      @deprecator ||= ActiveSupport::Deprecation.new(
        Gem::Version.new(VERSION).bump, 
        'SolidusJwt'
      )
    end
  end
end

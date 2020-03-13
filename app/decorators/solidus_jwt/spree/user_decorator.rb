module SolidusJwt
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.has_many :auth_tokens, class_name: 'SolidusJwt::Token'
      end

      ##
      # Generate a json web token
      # @see https://github.com/jwt/ruby-jwt
      # @return [String]
      #
      def generate_jwt(expires_in: nil)
        SolidusJwt.encode(payload: as_jwt_payload, expires_in: expires_in)
      end
      alias generate_jwt_token generate_jwt

      ##
      # Serializes user attributes to hash and applies
      # the sub jwt claim.
      #
      # @return [Hash] The payload for json web token
      #
      def as_jwt_payload
        options = SolidusJwt::Config.jwt_options
        claims = { sub: id }

        as_json(options)
          .merge(claims)
          .as_json
      end

      ::Spree.user_class.prepend self
    end
  end
end

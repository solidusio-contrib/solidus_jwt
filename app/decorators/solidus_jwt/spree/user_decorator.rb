module SolidusJwt
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.extend ClassMethods
        base.has_many :auth_tokens, class_name: 'SolidusJwt::Token'
      end

      module ClassMethods
        ##
        # Find user based on subject claim in
        # our json web token
        # @see https://tools.ietf.org/html/rfc7519#section-4.1.2
        #
        # @example get user token
        #   payload = SolidusJwt.decode(token).first
        #   user = Spree::User.for_jwt(payload['sub'])
        #
        # @param sub [string] The subject claim of jwt
        # @return [Spree.user_class, NilClass] If a match is found, returns the user,
        #   otherwise, returns nil
        #
        def for_jwt(sub)
          find_by(id: sub)
        end
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

module SolidusJwt
  module Encodeable
    ##
    # Encode a specified payload
    # @see https://github.com/jwt/ruby-jwt
    #
    # @param payload [Hash] Attributes to place within the jwt
    # @param expires_in [Integer] How long until token expires in Seconds (*Optional*).
    #   Note that if no expires at is set, then the token will last forever.
    # @return [String]
    #
    def encode(payload:, expires_in: nil)
      # @see https://github.com/jwt/ruby-jwt#support-for-reserved-claim-names
      extras = {}
      extras['exp'] = Time.current.to_i + expires_in if expires_in.present?
      extras['iat'] = Time.current

      payload = extras.merge(payload)
      JWT.encode(payload, SolidusJwt::Config.jwt_secret,
        SolidusJwt::Config.jwt_algorithm)
    end
  end
end

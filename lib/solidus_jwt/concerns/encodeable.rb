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
      current_time = Time.current
      extras = {}
      extras['exp'] = current_time.to_i + expires_in if expires_in.present?
      extras['iat'] = current_time

      payload = extras.merge(payload).as_json
      JWT.encode(payload, SolidusJwt::Config.jwt_secret,
        SolidusJwt::Config.jwt_algorithm)
    end
  end
end

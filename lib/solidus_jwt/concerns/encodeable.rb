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
      jwt_payload = payload.dup.with_indifferent_access

      current_time = Time.current.to_i

      # @see https://github.com/jwt/ruby-jwt#support-for-reserved-claim-names
      jwt_payload[:exp] ||= current_time + expires_in if expires_in.present?
      jwt_payload[:iat] ||= current_time
      jwt_payload[:iss] ||= 'solidus'

      JWT.encode(jwt_payload, SolidusJwt::Config.jwt_secret,
                 SolidusJwt::Config.jwt_algorithm)
    end
  end
end

Spree.user_class.class_eval do
  ##
  # Generate a json web token
  # @see https://github.com/jwt/ruby-jwt
  # @return [String]
  #
  def generate_jwt_token(expires_in: nil)
    SolidusJwt.encode(payload: as_jwt_payload, expires_in: expires_in)
  end

  private

  def as_jwt_payload
    as_json(only: %i[email id])
  end
end

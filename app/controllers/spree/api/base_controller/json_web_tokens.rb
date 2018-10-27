module Spree::Api::BaseController::JsonWebTokens
  def load_user
    return super unless json_web_token.present?
    @current_api_user ||= Spree.user_class.find_by(id: json_web_token['id'])
  end

  def json_web_token
    @json_web_token ||= SolidusJwt.decode(api_key).first
  rescue JWT::DecodeError
    # Allow spree to try and authenticate if we still allow it. Otherwise
    # raise an error
    return if SolidusJwt::Config.allow_spree_api_key
    raise
  end

  def invalid_jwt_format?
    api_key.split('.').size != 3
  end
end

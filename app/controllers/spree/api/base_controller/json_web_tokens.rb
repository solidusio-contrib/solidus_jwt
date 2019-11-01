##
# Prepend for Spree::Api::BaseController methods
#
module Spree::Api::BaseController::JsonWebTokens
  def load_user
    return super unless json_web_token.present?

    # rubocop:disable Naming/MemoizedInstanceVariableName
    @current_api_user ||= Spree.user_class.find_by(id: json_web_token['id'])
    # rubocop:enable Naming/MemoizedInstanceVariableName
  end

  def json_web_token
    @json_web_token ||= SolidusJwt.decode(api_key).first
  rescue JWT::DecodeError
    # Allow spree to try and authenticate if we still allow it. Otherwise
    # raise an error
    return if SolidusJwt::Config.allow_spree_api_key

    raise
  end
end

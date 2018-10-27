Spree::Api::BaseController.class_eval do
  prepend Spree::Api::BaseController::JsonWebTokens

  rescue_from JWT::DecodeError do
    render "spree/api/errors/invalid_api_key", status: 401
  end
end

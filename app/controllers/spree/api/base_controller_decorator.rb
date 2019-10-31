module Spree
  module Api
    module BaseControllerDecorator
      extend ActiveSupport::Concern

      included do
        prepend Spree::Api::BaseController::JsonWebTokens

        rescue_from JWT::DecodeError do
          render "spree/api/errors/invalid_api_key", status: 401
        end
      end

      Spree::Api::BaseController.include self
    end
  end
end

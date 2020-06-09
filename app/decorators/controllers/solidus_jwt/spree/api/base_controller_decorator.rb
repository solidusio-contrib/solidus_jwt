module SolidusJwt
  module Spree
    module Api
      module BaseControllerDecorator
        def self.prepended(base)
          base.rescue_from JWT::DecodeError do
            render "spree/api/errors/invalid_api_key", status: :unauthorized
          end
        end

        ##
        # Overrides Solidus
        # @see https://github.com/solidusio/solidus/blob/master/api/app/controllers/spree/api/base_controller.rb
        #
        def load_user
          return super if json_web_token.blank?

          # rubocop:disable Naming/MemoizedInstanceVariableName
          @current_api_user ||= ::Spree.user_class.for_jwt(json_web_token['sub'] || json_web_token['id'])
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

        if SolidusSupport.api_available?
          ::Spree::Api::BaseController.prepend self
        end
      end
    end
  end
end

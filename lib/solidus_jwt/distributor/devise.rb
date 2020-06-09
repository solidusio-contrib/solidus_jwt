# frozen_string_literal: true

module SolidusJwt
  module Distributor
    module Devise
      def after_sign_in_path_for(resource)
        # Send back json web token in redirect header
        if try_spree_current_user
          response.headers['X-SPREE-TOKEN'] = try_spree_current_user.
                                              generate_jwt_token(expires_in: SolidusJwt::Config.jwt_expiration)
        end

        super
      end
    end
  end
end

module SolidusJwt
  module DeviseStrategies
    class RefreshToken < Devise::Strategies::Base
      def valid?
        valid_grant_type? && valid_params?
      end

      def authenticate!
        resource = SolidusJwt::Token.find_by(auth_hash)
        return fail!(:invalid) if resource.nil? || resource.user.nil?

        block = Proc.new do
          # If we honor then mark the refresh token as stale for one time use
          resource.honor? && resource.update_columns(active: false)
        end

        if resource.user.valid_for_authentication?(&block)
          return success!(resource.user)
        end

        fail!(:invalid)
      end

      private

      def auth_hash
        { auth_type: :refresh, token: refresh_token }
      end

      def grant_type
        params[:grant_type]
      end

      def refresh_token
        params[:refresh_token]
      end

      def valid_grant_type?
        grant_type == 'refresh_token'
      end

      def valid_params?
        refresh_token.present?
      end
    end
  end
end

Warden::Strategies.add(:solidus_jwt_refresh_token, SolidusJwt::DeviseStrategies::RefreshToken)

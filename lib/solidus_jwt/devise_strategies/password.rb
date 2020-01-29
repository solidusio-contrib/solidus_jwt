module SolidusJwt
  module DeviseStrategies
    class Password < Base
      def authenticate!
        resource = mapping.to.find_for_database_authentication(auth_hash)

        block = proc { resource.valid_password?(password) }

        if resource&.valid_for_authentication?(&block)
          resource.after_database_authentication
          return success!(resource)
        end

        fail!(:invalid)
      end

      private

      def auth_hash
        { email: username }
      end

      def username
        params[:username]
      end

      def password
        params[:password]
      end

      def valid_grant_type?
        grant_type == 'password'
      end

      def valid_params?
        username.present? && password.present?
      end
    end
  end
end

Warden::Strategies.add(:solidus_jwt_password, SolidusJwt::DeviseStrategies::Password)

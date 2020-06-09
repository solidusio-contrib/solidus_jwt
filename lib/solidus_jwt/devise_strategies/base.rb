# frozen_string_literal: true

module SolidusJwt
  module DeviseStrategies
    class Base < Devise::Strategies::Authenticatable
      def valid?
        valid_grant_type? && valid_params?
      end

      private

      def grant_type
        params[:grant_type]
      end

      def valid_grant_type?
        raise NotImplementedError
      end

      def valid_params?
        raise NotImplementedError
      end
    end
  end
end

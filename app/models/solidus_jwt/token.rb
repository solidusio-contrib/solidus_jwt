module SolidusJwt
  class Token < ApplicationRecord
    attr_readonly :token
    enum auth_type: %i[refresh_token access_token]

    belongs_to :user, class_name: Spree::UserClassHandle.new

    scope :non_expired, -> {
      where(
        'solidus_jwt_tokens.created_at >= ?',
        SolidusJwt::Config.refresh_expiration.seconds.ago
      )
    }

    enum auth_type: %i[refresh access]

    validates :token, presence: true

    before_validation(on: :create) do
      self.token ||= SecureRandom.uuid
    end

    ##
    # Set all  non expired refresh tokens to inactive
    #
    def self.invalidate(user)
      non_expired.
        where(user_id: user.to_param).
        update_all(active: false)
    end

    ##
    # Whether to honor a token or not.
    # @return [Boolean]
    #
    def self.honor?(token)
      non_expired.where(active: true).find_by(token: token).present?
    end

    def honor?
      active? && !expired?
    end

    def expired?
      created_at < SolidusJwt::Config.refresh_expiration.seconds.ago
    end
  end
end

require 'spree/preferences/configuration'

module SolidusJwt
  class Preferences < Spree::Preferences::Configuration
    ##
    # Provide your own secret when creating json web tokens
    # @attr_writer jwt_secret [String] The secret to encrypt web tokens with.
    #
    attr_writer :jwt_secret

    ##
    # @see https://github.com/jwt/ruby-jwt#algorithms-and-usage
    # @!attribute [rw] jwt_algorithm
    #   @return [String] The hashing algorithm to use. (default 'HS256')
    #
    preference :jwt_algorithm, :string, default: 'HS256'

    # @!attribute [rw] jwt_expiration
    #   @return [String] How long until the token expires in seconds.
    #   (default: +3600+)
    #
    preference :jwt_expiration, :integer, default: 3600

    # @see https://github.com/jwt/ruby-jwt#algorithms-and-usage
    # @!attribute [rw] jwt_options
    #   @return [String] The options to pass into `Spree::User#as_json` when
    #   when creating the jwt payload. (default: `{ only: %i[email first_name id last_name] }`)
    #
    preference :jwt_options, :hash, default: { only: %i[email first_name id last_name] }

    ##
    # Get the secret token to encrypt json web tokens with.
    # @return [String] The secret used to encrypt json web tokens
    #
    #
    def jwt_secret
      # Account for different rails versions
      @jwt_secret ||= ENV['SECRET_KEY_BASE'] || Rails.application.secret_key_base
    end
  end
end

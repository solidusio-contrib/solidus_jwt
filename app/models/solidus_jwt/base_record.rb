# frozen_string_literal: true

module SolidusJwt
  base_class = defined?(::ApplicationRecord) ? ::ApplicationRecord : ActiveRecord::Base

  class BaseRecord < base_class
    self.abstract_class = true

    def self.table_name_prefix
      'solidus_jwt_'
    end
  end
end

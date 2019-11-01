module SolidusJwt
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true

    def self.table_name_prefix
      'solidus_jwt_'
    end
  end
end

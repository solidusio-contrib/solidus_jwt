# frozen_string_literal: true

class AddForeignKeyToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :solidus_jwt_tokens, Spree.user_class.table_name, column: :user_id, on_delete: :cascade
  end
end

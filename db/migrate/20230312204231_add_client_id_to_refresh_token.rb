class AddClientIdToRefreshToken < ActiveRecord::Migration[7.0]
  def change
    add_column :solidus_jwt_tokens, :client_id, :string
  end
end

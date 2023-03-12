class AddClientIdToRefreshToken < ActiveRecord::Migration[5.2]
  def change
    add_column :solidus_jwt_tokens, :client_id, :string
  end
end

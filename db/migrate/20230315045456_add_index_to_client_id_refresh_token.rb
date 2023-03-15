class AddIndexToClientIdRefreshToken < ActiveRecord::Migration[5.2]
  def change
    add_index :solidus_jwt_tokens, :client_id
  end
end

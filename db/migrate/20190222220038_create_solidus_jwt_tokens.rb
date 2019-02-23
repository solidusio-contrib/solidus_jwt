class CreateSolidusJwtTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :solidus_jwt_tokens do |t|
      t.string :token, index: true
      t.integer :auth_type, default: 0, null: false
      t.integer :user_id, index: true
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end
  end
end

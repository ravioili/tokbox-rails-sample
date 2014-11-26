class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :session_id
      t.text :token
      t.boolean :active

      t.timestamps
    end
  end
end

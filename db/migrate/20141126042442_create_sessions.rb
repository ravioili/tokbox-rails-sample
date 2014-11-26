class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :sessionid
      t.boolean :open

      t.timestamps
    end
  end
end

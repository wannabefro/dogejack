class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
  end
end

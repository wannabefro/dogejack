class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, null: false, index: true
      t.string :player_cards, default: [], array: true
      t.string :dealer_cards, default: [], array: true

      t.timestamps
    end
  end
end

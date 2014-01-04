class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, null: false, index: true
      t.string :state, default: 'started', index: true
      t.string :player_cards, array: true, default: []
      t.string :dealer_cards, array: true, default: []

      t.timestamps
    end
  end
end

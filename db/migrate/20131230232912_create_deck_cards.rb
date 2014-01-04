class CreateDeckCards < ActiveRecord::Migration
  def change
    create_table :deck_cards do |t|
      t.integer :deck_id, index: true
      t.integer :card_id

      t.timestamps
    end
    add_index :deck_cards, [:deck_id, :card_id], :unique => true
  end
end

class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.belongs_to :game, null: false, index: true

      t.timestamps
    end
  end
end

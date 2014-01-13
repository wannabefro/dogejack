class GameSessionAssociations < ActiveRecord::Migration
  def change
    rename_column :decks, :game_id, :game_session_id
    add_column :games, :game_session_id, :integer, null: false
  end
end

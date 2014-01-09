class AddSplitToGame < ActiveRecord::Migration
  def change
    add_column :games, :split_cards, :string, array: true, default: []
    add_column :games, :split_bets, :string, array: true, default: []
    add_column :games, :split, :boolean, default: false
  end
end

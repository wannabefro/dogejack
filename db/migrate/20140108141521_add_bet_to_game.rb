class AddBetToGame < ActiveRecord::Migration
  def change
    add_column :games, :bet, :integer, default: 0, null: false
  end
end

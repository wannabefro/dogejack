class AddWinnerToGame < ActiveRecord::Migration
  def change
    add_column :games, :winner, :string, default: nil, index: true
  end
end

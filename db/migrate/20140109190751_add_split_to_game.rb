class AddSplitToGame < ActiveRecord::Migration
  def change
    add_column :games, :split, :boolean, default: false
  end
end

class AddGamescountToUser < ActiveRecord::Migration
  def change
    add_column :users, :games_count, :integer, null: false, default: 0
  end
end

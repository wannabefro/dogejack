class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.belongs_to :user, null: false
      t.integer :balance, default: 0, null: false
      t.timestamps
    end
    add_index :wallets, :user_id, unique: true
  end
end

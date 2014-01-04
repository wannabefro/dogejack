class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :value, null: false
      t.string :suit, null: false

    end
  end
end

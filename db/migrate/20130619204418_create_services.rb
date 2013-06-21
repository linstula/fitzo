class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :duration, null: false
      t.integer :price, null: false
      t.integer :user_id, null: false
      t.string :category

      t.timestamps
    end
  end
end

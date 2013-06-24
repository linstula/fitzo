class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :trainer_profile_id, null: false

      t.timestamps
    end
  end
end

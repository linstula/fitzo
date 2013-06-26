class AddUniquenessIndexToRecommendations < ActiveRecord::Migration
  def up
    add_index :recommendations, [:trainer_profile_id, :user_id], unique: true
  end

  def down
    remove_index :recommendations, name: "index_recommendations_on_trainer_profile_id_and_user_id"
  end
end

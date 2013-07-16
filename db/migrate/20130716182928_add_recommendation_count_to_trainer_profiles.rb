class AddRecommendationCountToTrainerProfiles < ActiveRecord::Migration
  def change
    add_column :trainer_profiles, :recommendations_count, :integer, default: 0, null: false
    execute "update trainer_profiles set recommendations_count=(select count(*) from recommendations where trainer_profile_id=trainer_profiles.id)"
  end
end

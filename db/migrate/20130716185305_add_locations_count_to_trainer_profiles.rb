class AddLocationsCountToTrainerProfiles < ActiveRecord::Migration
  def change
    add_column :trainer_profiles, :locations_count, :integer, default: 0, null: false
    execute "update trainer_profiles set locations_count=(select count(*) from locations where trainer_profile_id=trainer_profiles.id)"
  end
end

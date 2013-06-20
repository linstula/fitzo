class ChangeProfilesToTrainerProfiles < ActiveRecord::Migration
  def up
    rename_table :profiles, :trainer_profiles
  end

  def down
    rename_table :trainer_profiles, :profiles
  end
end

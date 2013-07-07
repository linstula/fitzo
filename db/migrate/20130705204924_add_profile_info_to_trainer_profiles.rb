class AddProfileInfoToTrainerProfiles < ActiveRecord::Migration
  def up
    add_column :trainer_profiles, :phone_number, :string, default: ""
    add_column :trainer_profiles, :website, :string, default: ""
    add_column :trainer_profiles, :about, :text, default: ""
  end

  def down
    remove_column :trainer_profiles, :phone_number
    remove_column :trainer_profiles, :website
    remove_column :trainer_profiles, :about
  end
end

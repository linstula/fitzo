class AddOwnerNameToTrainerProfiles < ActiveRecord::Migration
  def up
  	add_column :trainer_profiles, :owner_name, :string
  end

  def down
  	remove_column :trainer_profiles, :owner_name
  end
end

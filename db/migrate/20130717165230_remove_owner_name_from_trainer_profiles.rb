class RemoveOwnerNameFromTrainerProfiles < ActiveRecord::Migration
  def up
  	remove_column :trainer_profiles, :owner_name
  end

  def down
  	add_column :trainer_profiles, :owner_name, :string, default: "", null: false
  end
end

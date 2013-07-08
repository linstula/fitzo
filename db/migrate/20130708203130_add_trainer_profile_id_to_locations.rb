class AddTrainerProfileIdToLocations < ActiveRecord::Migration
  def up
  	add_column :locations, :trainer_profile_id, :integer
  end

  def down
  	remove_column :locations, :trainer_profile_id
  end
end

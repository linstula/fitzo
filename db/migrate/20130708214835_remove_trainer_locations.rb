class RemoveTrainerLocations < ActiveRecord::Migration
  def up
  	drop_table :trainer_locations
  end

  def down
  	create_table :trainer_locations do |t|
      t.integer :trainer_profile_id
      t.integer :location_id

      t.timestamps
    end
  end
end

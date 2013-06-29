class CreateTrainerLocations < ActiveRecord::Migration
  def change
    create_table :trainer_locations do |t|
      t.integer :trainer_profile_id
      t.integer :location_id

      t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :neighborhood
      t.float :latitude
      t.float :longitude
      t.string :full_address

      t.timestamps
    end
  end
end

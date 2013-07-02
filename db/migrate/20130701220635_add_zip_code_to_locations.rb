class AddZipCodeToLocations < ActiveRecord::Migration
  def up
    add_column :locations, :zip_code, :string
  end

  def down
    remove_column :locations, :zip_code
  end
end

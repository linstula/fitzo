class RemoveZipCodeFromLocaitons < ActiveRecord::Migration
  def up
    remove_column :locations, :zip_code
  end

  def down
    add_column :locations, :zip_code, :string
  end
end

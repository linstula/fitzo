class AddUniquenessIndexToTrainerSpecialties < ActiveRecord::Migration
  def up
    add_index :trainer_specialties, [:trainer_profile_id, :specialty_id], unique: true, name: "trainer_specialties_uniqeness_index"
  end

  def down
    remove_index :trainer_specialties, name: "trainer_specialties_uniqeness_index"
  end
end

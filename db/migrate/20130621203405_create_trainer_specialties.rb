class CreateTrainerSpecialties < ActiveRecord::Migration
  def change
    create_table :trainer_specialties do |t|
      t.integer :trainer_profile_id, null: false
      t.integer :specialty_id, null: false

      t.timestamps
    end
  end
end

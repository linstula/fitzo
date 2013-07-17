class AddForeignKeyIndexes < ActiveRecord::Migration
  def up
  	add_index :locations, :trainer_profile_id
  	
  	add_index :recommendations, :trainer_profile_id
  	add_index :recommendations, :user_id
  	
  	add_index :services, :trainer_profile_id
  	
  	add_index :trainer_profiles, :user_id

  	add_index :trainer_specialties, :trainer_profile_id
  	add_index :trainer_specialties, :specialty_id
  end

  def down
  	remove_index :locations, :trainer_profile_id
  	
  	remove_index :recommendations, :trainer_profile_id
  	remove_index :recommendations, :user_id
  	
  	remove_index :services, :trainer_profile_id
  	
  	remove_index :trainer_profiles, :user_id

  	remove_index :trainer_specialties, :trainer_profile_id
  	remove_index :trainer_specialties, :specialty_id
  end
end

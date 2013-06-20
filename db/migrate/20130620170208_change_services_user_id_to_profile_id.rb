class ChangeServicesUserIdToProfileId < ActiveRecord::Migration
  def up
    rename_column :services, :user_id, :trainer_profile_id
  end

  def down
    rename_column :services, :trainer_profile_id, :user_id
  end
end

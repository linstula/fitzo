class ChangeProfileServiceDurationToString < ActiveRecord::Migration
  def up
    change_column :services, :duration, :string, null: false
  end

  def down
    remove_column :services, :duration
    add_column :services, :duration, :integer
  end
end

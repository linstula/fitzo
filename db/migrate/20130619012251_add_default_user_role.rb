class AddDefaultUserRole < ActiveRecord::Migration
  def up
    change_column :users, :role, :string, default: "member"
  end

  def down
    change_column :users, :role, :string, default: "user"
  end
end

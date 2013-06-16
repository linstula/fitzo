class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string,    null: false, default: ""
    add_column :users, :first_name, :string,  null: false, default: ""
    add_column :users, :last_name, :string,   null: false, default: ""
    add_column :users, :role, :string,        null: false, default: "user"
  end

  def down
    remove_column :users, :username
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :role
  end
end

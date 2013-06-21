class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :title, null: false, default: ""
      t.timestamps
    end
  end
end

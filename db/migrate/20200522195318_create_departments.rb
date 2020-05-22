class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.date :formed_at, null: false
      t.date :disbanded_at
      t.integer :parent_id
    end
  end
end

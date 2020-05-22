class CreateEmployee < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
    end
  end
end

class CreateEmployments < ActiveRecord::Migration[5.2]
  def change
    create_table :employments do |t|
      t.integer :employee_id, null: false
      t.integer :department_id, null: false
      t.date :start_date, null: false
      t.date :end_date
    end
  end
end

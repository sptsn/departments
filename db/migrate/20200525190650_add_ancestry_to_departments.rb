class AddAncestryToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :ancestry, :string, index: true
  end
end

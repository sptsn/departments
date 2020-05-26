class RemoveParentId < ActiveRecord::Migration[5.2]
  def change
    remove_column :departments, :parent_id
  end
end

class ChangeVersions < ActiveRecord::Migration[5.2]
  def change
    drop_table :versions

    create_table :department_versions do |t|
      t.integer :department_id
      t.string :name
      t.string :ancestry
      t.datetime :active_since
      t.timestamps
    end
  end
end

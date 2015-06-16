class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :description
      t.string :license
      t.string :number
      t.integer :package_id
      t.string :shasum

      t.timestamps null: false
    end
  end
end

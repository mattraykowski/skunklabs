class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.text :goals
      t.text :measurements
      t.integer :focus_type_id

      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :comment
      t.string :subject
      t.boolean :is_update
      t.integer :progress

      t.timestamps
    end
  end
end

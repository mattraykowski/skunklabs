class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :creator_id, null: false
      t.integer :team_member_id
      t.integer :status_id, null: false, default: 0
      t.datetime :completion_date
      t.text :notes

      t.timestamps
    end
  end
end

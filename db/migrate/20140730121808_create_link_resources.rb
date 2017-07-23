class CreateLinkResources < ActiveRecord::Migration
  def change
    create_table :link_resources do |t|
      t.integer :lab_id
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end

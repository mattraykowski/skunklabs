class CreateFocusTypes < ActiveRecord::Migration
  def change
    create_table :focus_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

class CreateLabSupporters < ActiveRecord::Migration
  def change
    create_table :lab_supporters do |t|
      t.integer :user_id, null: false
      t.integer :lab_id, null: false

      t.timestamps
    end

    add_index :lab_supporters, [:user_id, :lab_id], unique: true
  end
end

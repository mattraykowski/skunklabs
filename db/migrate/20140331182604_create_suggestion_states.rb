class CreateSuggestionStates < ActiveRecord::Migration
  def change
    create_table :suggestion_states do |t|
      t.string :name, null: false
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end

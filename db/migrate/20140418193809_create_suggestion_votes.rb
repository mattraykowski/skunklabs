class CreateSuggestionVotes < ActiveRecord::Migration
  def change
    create_table :suggestion_votes do |t|
      t.integer :suggestion_id
      t.integer :user_id

      t.timestamps
    end
  end
end

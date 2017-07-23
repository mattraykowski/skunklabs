class AddSuggestionTeamMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suggestion_team_member, :boolean, default: false
  end
end

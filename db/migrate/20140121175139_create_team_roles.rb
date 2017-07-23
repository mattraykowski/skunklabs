class CreateTeamRoles < ActiveRecord::Migration
  def change
    create_table :team_roles do |t|
      t.integer :project_id
      t.integer :role_type_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end

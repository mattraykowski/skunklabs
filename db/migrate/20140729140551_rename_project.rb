class RenameProject < ActiveRecord::Migration
  def change
    # Rename the projects table
    rename_table :projects, :labs

    # Rename foreign key columns
    rename_column :comments, :project_id, :lab_id
    rename_column :team_roles, :project_id, :lab_id

    # Fix the seeded Focus Type values.
    FocusType.find_each do |focus_type|
      focus_type.description.gsub /project/, 'lab'
    end
  end
end

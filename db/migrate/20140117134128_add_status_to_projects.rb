class AddStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status, :integer, null: false, default: 0
  end
end

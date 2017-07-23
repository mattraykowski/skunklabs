class AddDirectoryAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :displayname, :string
    add_column :users, :job_title, :string
    add_column :users, :department, :string
  end
end

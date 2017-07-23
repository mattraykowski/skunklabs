class AddLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string, null: false, default: ''
    
    User.all.each do |user|
      user.login = user.email
      user.save
    end
    
    change_column :users, :login, :string, null: false, default: '', unique: true
    
    add_index :users, :login, unique: true
  end
end

class AddMeetingNoticeToUser < ActiveRecord::Migration
  def change
    add_column :users, :meeting_notice, :boolean, default: false
  end
end

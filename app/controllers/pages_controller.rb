class PagesController < ApplicationController
  def index
    @newest_lab = Lab.last
    comment = Comment.where(is_update: true).order('created_at DESC').first
    @latest_lab = comment.lab unless comment.nil?
  end

  def recent_updates
    @recent_updates = Comment.order('created_at DESC').limit(10)
  end

  def about
    @team = User.all_team_members
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :admin, :team, :notices]
  before_action :must_be_admin, except: :notices
  before_action :verify_ownership, only: :notices

  def index
    @users = User.all
  end

  def edit
  end

  def admin
    respond_to do |format|
      if @user.update( admin: params[:admin])
        format.json { head :no_content }
      else
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end

  def team
    respond_to do |format|
      if @user.update( suggestion_team_member: params[:team])
        format.json { head :no_content }
      else
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end

  def notices
    respond_to do |format|
      if @user.update( meeting_notice: params[:notices])
        format.json { head :no_content }
      else
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end

  def noticelist
    @users = User.all
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def verify_ownership
      redirect_to root_url unless me?(@user) || current_user.admin
    end
end

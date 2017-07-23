class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def notices
    respond_to do |format|
      if current_user.update( meeting_notice: params[:notices])
        format.json { head :no_content }
      else
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end
end

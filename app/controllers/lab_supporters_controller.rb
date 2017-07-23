class LabSupportersController < ApplicationController
  before_action :get_lab
  before_action :authenticate_user!, except: [:supporters]

  # GET /labs/1/support
  def support
    respond_to do |format|
      if @lab.is_team_member?(current_user) || @lab.is_owner?(current_user)
        format.html { redirect_to @lab, notice: "You cannot support a lab you're already a member of."}
      else
        lab_support = LabSupporter.new(user: current_user, lab: @lab)
        if lab_support.save
          format.html { redirect_to @lab, notice: "Now supporting '#{@lab.name}'" }
          format.json { render action: 'show', status: :created, location: @lab }
        else
          format.html { redirect_to @lab }
          format.json { render json: @lab.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # GET /labs/1/unsupport
  def unsupport
    respond_to do |format|
      support = LabSupporter.where(['user_id = ? and lab_id = ?', current_user.id, @lab.id]).first
      support.destroy unless support.nil?

      format.html { redirect_to @lab }
      format.json { head :no_content }
    end
  end

  def supporters
    @lab_supporters = LabSupporter.where('lab_id = ?', @lab.id)
    @lab_supporters
  end

  private
    def get_lab
      @lab = Lab.find_by_id(params[:lab_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_supporter_params
      params.require(:lab_supporter).permit(:lab_id)
    end
end

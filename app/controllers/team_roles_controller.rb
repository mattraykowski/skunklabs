class TeamRolesController < ApplicationController
  before_action :get_lab
  before_action :set_team_role, only: [:show, :edit, :update, :destroy, :take_role, :release_role]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :must_be_team_member, except: [:index, :show, :take_role, :release_role]

  # GET /team_roles
  # GET /team_roles.json
  def index
    @team_roles = TeamRole.where(lab: @lab)
  end

  # GET /team_roles/1
  # GET /team_roles/1.json
  def show
  end

  # GET /team_roles/new
  def new
    @team_role = TeamRole.new
    @team_role.lab = @lab
  end

  # GET /team_roles/1/edit
  def edit
  end

  # POST /team_roles
  # POST /team_roles.json
  def create
    @team_role = TeamRole.new(team_role_params)

    respond_to do |format|
      if @team_role.save
        format.html { redirect_to lab_team_roles_path(@lab), notice: 'Team role was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_role }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_roles/1
  # PATCH/PUT /team_roles/1.json
  def update
    respond_to do |format|
      if @team_role.update(team_role_params)
        format.html { redirect_to lab_team_roles_path(@lab), notice: 'Team role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_roles/1
  # DELETE /team_roles/1.json
  def destroy
    @team_role.destroy
    respond_to do |format|
      format.html { redirect_to lab_team_roles_path(@lab) }
      format.json { head :no_content }
    end
  end

  def take_role
    if @team_role.user.nil?
      @team_role.user = current_user
      respond_to do |format|
        if @team_role.save
          format.html { redirect_to @lab, notice: 'Assumed lab role.' }
          format.json { render action: 'show', status: :created, location: @team_role }
        else
          format.html { redirect_to @lab, notice: 'Failed to take role.' }
          format.json { render json: @team_role.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @lab, flash: { warning: "You cannot take this role, someone else already has it!" } }
        format.json { render json: @team_role.errors, status: :unprocessable_entity }
      end
    end
  end

  def release_role
    if @team_role.user.id == current_user.id || @lab.user.id == current_user.id
      @team_role.user = nil
      respond_to do |format|
        if @team_role.save
          format.html { redirect_to @lab, notice: 'Released lab role.' }
          format.json { render action: 'show', status: :created, location: @team_role }
        else
          format.html { redirect_to @lab, notice: 'Failed to release role.' }
          format.json { render json: @team_role.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @lab, flash: { warning: "You cannot release this role, it belongs to someone else!" } }
        format.json { render json: @team_role.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_lab
      @lab = Lab.find_by_id(params[:lab_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team_role
      @team_role = TeamRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_role_params
      params.require(:team_role).permit(:lab_id, :role_type_id, :user_id, :comment)
    end
end

class LabsController < ApplicationController
  before_action :set_lab, except: [:index, :new, :create]
  before_action :set_overall_progress, only: :show
  before_action :authenticate_user!, except: [:index, :show]
  before_action :must_be_founder, only: [:start]

  # GET /labs
  # GET /labs.json
  def index
    if params[:by] == 'me'
      @labs = Lab.where('user_id = ?', current_user.id)
    elsif params[:by] =~ /[0-4]/
      @labs = Lab.where('status = ?', params[:by])
    else
      @labs = Lab.all
    end
  end

  # GET /labs/1
  # GET /labs/1.json
  def show

    # We need to stub a comment for the add comment/update button.
    @comment = Comment.new
    @comment.lab = @lab
    @comment.user = current_user if user_signed_in?

    # Determine if the current user is a supporter.
    @is_supporter = false
    if user_signed_in?
      @lab.lab_supporters.each do |supporter|
        @is_supporter = true if supporter.user.id == current_user.id
      end
    end
  end

  # GET /labs/new
  def new
    @lab = Lab.new
    @lab.user = current_user
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)
    @lab.user = current_user

    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lab }
      else
        format.html { render action: 'new' }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url }
      format.json { head :no_content }
    end
  end

  def start
    make_transition Lab::STARTED
  end

  def complete
    make_transition Lab::COMPLETED
  end

  def block
    make_transition Lab::BLOCKED
  end

  def abandon
    make_transition Lab::ABANDONED
  end

  def make_transition(to_state)
    respond_to do |format|
      if @lab.transition_okay? to_state
        @lab.status = to_state
        @lab.save
        format.html { redirect_to @lab, notice: "The lab is now <strong>#{@lab.status_name}</strong>.".html_safe }
        format.json { head :no_content }
      else
        format.html { redirect_to @lab, flash: { warning: "You cannot change to a '#{Lab::STATUSES[to_state]}' state." } }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
      #@lab.team_roles.build
    end

    def set_overall_progress
      @overall_progress = @lab.overall_progress
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:name, :goals, :measurements, :focus_type_id)
    end
end

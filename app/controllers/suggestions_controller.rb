class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :must_be_suggestion_team_member, only: [:update, :destroy]
  before_action :prepare_suggestion_sidebar


  # GET /suggestions
  # GET /suggestions.json
  def index
    order_by = :id
    per_page = 10

    # Handle the filters. They're either 'me' or the status ID.
    if params[:by] == 'me'
      @suggestions = Suggestion.where('creator_id = ?', current_user.id).order(order_by).page(params[:page]).per(per_page)
    elsif params[:by] =~ /[0-9]+/
      @suggestions = Suggestion.where('status_id = ?', params[:by]).order(order_by).page(params[:page]).per(per_page)
    elsif params[:by] == 'all'
      @suggestions = Suggestion.order(order_by).page(params[:page]).per(per_page)
    else
      @suggestions = Suggestion.joins(:status).merge(SuggestionState.where(done: false)).order(order_by).page(params[:page]).per(per_page)
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
    @suggestion.creator = current_user
    @suggestion.status = SuggestionState.first
  end

  # GET /suggestions/1/edit
  def edit
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.creator = current_user
    @suggestion.status = SuggestionState.first

    respond_to do |format|
      if @suggestion.save
        SuggestionMailer.suggestion_created(@suggestion).deliver

        format.html { redirect_to suggestions_path, notice: 'Suggestion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @suggestion }
      else
        format.html { render action: 'new' }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to suggestions_path, notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    destroyer = Hash.new
    destroyer[:email] = 'noreply@childrensmn.org'
    destroyer[:name] = 'Skunk Labs System'
    if user_signed_in?
      destroyer[:email] = current_user.email
      destroyer[:name] = current_user.safe_name
    end
    SuggestionMailer.suggestion_destroyed(@suggestion, destroyer).deliver

    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :team_member_id, :status_id, :completion_date, :notes)
    end
end

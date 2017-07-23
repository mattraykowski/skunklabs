class SuggestionStatesController < ApplicationController
  before_action :set_suggestion_state, only: [:show, :edit, :update, :destroy]
  before_action :must_be_admin

  # GET /suggestion_states
  # GET /suggestion_states.json
  def index
    @suggestion_states = SuggestionState.all
  end

  # GET /suggestion_states/1
  # GET /suggestion_states/1.json
  def show
  end

  # GET /suggestion_states/new
  def new
    @suggestion_state = SuggestionState.new
  end

  # GET /suggestion_states/1/edit
  def edit
  end

  # POST /suggestion_states
  # POST /suggestion_states.json
  def create
    @suggestion_state = SuggestionState.new(suggestion_state_params)

    respond_to do |format|
      if @suggestion_state.save
        format.html { redirect_to @suggestion_state, notice: 'Suggestion state was successfully created.' }
        format.json { render action: 'show', status: :created, location: @suggestion_state }
      else
        format.html { render action: 'new' }
        format.json { render json: @suggestion_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestion_states/1
  # PATCH/PUT /suggestion_states/1.json
  def update
    respond_to do |format|
      if @suggestion_state.update(suggestion_state_params)
        format.html { redirect_to @suggestion_state, notice: 'Suggestion state was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @suggestion_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestion_states/1
  # DELETE /suggestion_states/1.json
  def destroy
    @suggestion_state.destroy
    respond_to do |format|
      format.html { redirect_to suggestion_states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion_state
      @suggestion_state = SuggestionState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_state_params
      params.require(:suggestion_state).permit(:name, :done)
    end
end

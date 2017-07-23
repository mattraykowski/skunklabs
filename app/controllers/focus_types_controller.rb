class FocusTypesController < ApplicationController
  before_action :set_focus_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :must_be_admin
  
  # GET /focus_types
  # GET /focus_types.json
  def index
    @focus_types = FocusType.all
  end

  # GET /focus_types/1
  # GET /focus_types/1.json
  def show
  end

  # GET /focus_types/new
  def new
    @focus_type = FocusType.new
  end

  # GET /focus_types/1/edit
  def edit
  end

  # POST /focus_types
  # POST /focus_types.json
  def create
    @focus_type = FocusType.new(focus_type_params)

    respond_to do |format|
      if @focus_type.save
        format.html { redirect_to @focus_type, notice: 'Focus type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @focus_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @focus_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /focus_types/1
  # PATCH/PUT /focus_types/1.json
  def update
    respond_to do |format|
      if @focus_type.update(focus_type_params)
        format.html { redirect_to @focus_type, notice: 'Focus type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @focus_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /focus_types/1
  # DELETE /focus_types/1.json
  def destroy
    @focus_type.destroy
    respond_to do |format|
      format.html { redirect_to focus_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_focus_type
      @focus_type = FocusType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def focus_type_params
      params.require(:focus_type).permit(:name, :description)
    end
end

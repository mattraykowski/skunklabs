class LinkResourcesController < ApplicationController
  before_action :get_lab
  before_action :set_link_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :must_be_team_member, except: [:index, :show]

  # GET /link_resources
  # GET /link_resources.json
  def index
    @link_resources = LinkResource.where(lab: @lab)
  end

  # GET /link_resources/1
  # GET /link_resources/1.json
  def show
  end

  # GET /link_resources/new
  def new
    @link_resource = LinkResource.new
    @link_resource.lab = @lab
  end

  # GET /link_resources/1/edit
  def edit
  end

  # POST /link_resources
  # POST /link_resources.json
  def create
    @link_resource = LinkResource.new(link_resource_params)

    respond_to do |format|
      if @link_resource.save
        format.html { redirect_to @lab, notice: 'Link resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @link_resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @link_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /link_resources/1
  # PATCH/PUT /link_resources/1.json
  def update
    respond_to do |format|
      if @link_resource.update(link_resource_params)
        format.html { redirect_to @lab, notice: 'Link resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /link_resources/1
  # DELETE /link_resources/1.json
  def destroy
    @link_resource.destroy
    respond_to do |format|
      format.html { redirect_to @lab }
      format.json { head :no_content }
    end
  end

  private
    def get_lab
      @lab = Lab.find_by_id(params[:lab_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_link_resource
      @link_resource = LinkResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_resource_params
      params.require(:link_resource).permit(:lab_id, :name, :url, :description)
    end
end

class CommentsController < ApplicationController
  before_action :get_lab
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :restrict_only_owner, only: [:destroy, :edit, :update]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(lab: @lab)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @comment.lab = @lab
    @comment.user = current_user if user_signed_in?
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @lab, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @lab, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @lab }
      format.json { head :no_content }
    end
  end

  private
    def get_lab
      @lab = Lab.find_by_id(params[:lab_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def restrict_only_owner
      redirect_to @lab unless current_user.id == @comment.user_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :lab_id, :comment, :subject, :is_update, :progress)
    end
end

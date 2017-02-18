class SubsController < ApplicationController
  before_action :set_sub, only: [:show, :edit, :update, :destroy]
  before_action :require_moderator, only: [:edit, :update, :destroy]

  # GET /subs
  # GET /subs.json
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
  end

  # GET /subs/new
  def new
    @sub = Sub.new
    @action = "Create"
  end

  # GET /subs/1/edit
  def edit
    @action = "Update"
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      @action = "Create"
      render :new
    end
  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update
    if @sub.update(sub_params)
      redirect_to @sub
    else
      render :edit
    end
  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    @sub.destroy
    redirect_to subs_url
  end

  def require_moderator
    redirect_to root_url unless @sub.moderator == current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub
      @sub = Sub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_params
      params.require(:sub).permit(:title, :description, :user_id)
    end
end

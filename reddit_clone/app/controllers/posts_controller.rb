class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]

  def require_author
    redirect_to root_url unless @post.author == current_user
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    @action = "Create"
  end

  def edit
    @action = "Update"
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]

    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      @action = "Create"
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [] )
    end
end

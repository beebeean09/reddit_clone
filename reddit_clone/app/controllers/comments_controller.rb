class CommentsController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]

  def require_login
    redirect_to new_session_url unless current_user
  end

  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @comment.post
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :comment_id)
  end
end

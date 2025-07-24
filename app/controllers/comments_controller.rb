class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), alert: "Comment not created. Please try again."
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end

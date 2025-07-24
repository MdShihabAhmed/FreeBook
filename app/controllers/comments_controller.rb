class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), alert: "Comment not created. Please try again."
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end

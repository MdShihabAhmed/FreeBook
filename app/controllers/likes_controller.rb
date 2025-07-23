class LikesController < ApplicationController
  before_action :authenticate_user!
  def like
    @post = Post.find(params[:id])
    @like = Like.new(user: current_user, post: @post)
    @like.save
    redirect_to post_path(@post)
  end

  def unlike
    @post = Post.find(params[:id])
    @like = Like.find_by(user: current_user, post: @post)
    if @like
      @like.destroy
    end
    redirect_to post_path(@post)
  end
end

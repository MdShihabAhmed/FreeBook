class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    feed_users_ids = current_user.following.each do |user|
      user.id
    end
    feed_users_ids.push(current_user.id)
    @posts = Post.where(user_id: feed_users_ids).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to user_path
  end

  private
  def post_params
    params.expect(post: [ :title, :body ])
  end
end

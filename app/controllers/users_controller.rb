class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    @received_requests = @user.pending_received_requests
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following
    @sent_requests = @user.pending_sent_requests
  end
end

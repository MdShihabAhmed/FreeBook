class FollowRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :follow, :accept, :decline, :unfollow, :remove_follower, :cancel_request ]

  def follow
    @follow_request = FollowRequest.new(sender: current_user, receiver: @user)
    if @follow_request.save
      redirect_to @user, notice: "Follow request sent."
    else
      redirect_to @user, alert: "Unable to send follow request."
    end
  end

  def accept
    @follow_request = FollowRequest.find_by(sender: @user, receiver: current_user, accepted: false)
    if @follow_request
      @follow_request.update(accepted: true)
      redirect_to @user, notice: "Follow request accepted."
    else
      redirect_to @user, alert: "No pending follow request from this user."
    end
  end

  def decline
    @follow_request = FollowRequest.find_by(sender: @user, receiver: current_user, accepted: false)
    if @follow_request
      @follow_request.destroy
      redirect_to @user, notice: "Follow request declined."
    else
      redirect_to @user, alert: "No pending follow request from this user."
    end
  end

  def unfollow
    @follow_request = FollowRequest.find_by(
      "(sender_id = ? AND receiver_id = ? AND accepted = ?) OR (sender_id = ? AND receiver_id = ? AND accepted = ?)",
      current_user.id, @user.id, true,
      @user.id, current_user.id, true
    )
    if @follow_request
      @follow_request.destroy
      redirect_to @user, notice: "Unfollowed user."
    else
      redirect_to @user, alert: "You are not following this user."
    end
  end

  def remove_follower
    @follow_request = FollowRequest.find_by(sender: @user, receiver: current_user, accepted: true)
    if @follow_request
      @follow_request.destroy
      redirect_to @user, notice: "Follower removed."
    else
      redirect_to @user, alert: "This user is not a follower."
    end
  end

  def cancel_request
    @follow_request = FollowRequest.find_by(sender: current_user, receiver: @user, accepted: false)
    if @follow_request
      @follow_request.destroy
      redirect_to @user, notice: "Follow request cancelled."
    else
      redirect_to @user, alert: "No pending follow request to cancel."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

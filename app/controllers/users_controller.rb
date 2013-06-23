class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:follow, :unfollow]

  def show
    @user = User.find_by_username(params[:id])
  end

  def follow
    user = User.find_by_username(params[:id])
    follow_ids = current_user.following_ids
    current_user.following_ids = (follow_ids << user.id).uniq
    redirect_to :back
  end

  def unfollow
    user = User.find_by_username(params[:id])
    follow_ids = current_user.following_ids
    if follow_ids.include?(user.id)
      follow_ids.delete(user.id)
    end
    current_user.following_ids = follow_ids
    redirect_to :back
  end
end

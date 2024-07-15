# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

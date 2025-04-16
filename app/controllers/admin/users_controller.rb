class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def edit
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
  end

  def destroy
  end
end

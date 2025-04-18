class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @user = User.find(params[:id])
  end  

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザーステータスを更新しました"
    else
      flash[:alert] = "ステータス更新に失敗しました"
      render :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :status)
  end
end

class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  # ログインユーザーでない場合はアクセスできないようにする。
  before_action :is_matching_login_user, only: [:edit, :update, :mypage]

  def mypage
  end

  def edit
  end

  def show
  end

  def update
  end

  def unsubscribe
  end

  def destroy
  end

  def favorited_post
  end

  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to public_posts_path
    end
  end
end

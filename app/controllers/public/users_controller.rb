class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  # ログインユーザーでない場合はアクセスできないようにする。
  before_action :is_matching_login_user, only: [:edit, :update, :mypage, :destroy, :unsubscribe]

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id]), notice: "会員情報を更新しました！"
    else
      render :edit
    end
  end

  def unsubscribe
    # 退会確認ページへ遷移
    # ここで実際に退会処理を行うことはなく、destroyは`destroy` アクションに任せる
    render :unsubscribe # 退会確認ページに遷移
  end

  def destroy
    #devise標準（＝データベースの物理削除のケース）ならば記載不要。
    #論理削除であればここに記載が必要。
  end

  def favorited_post
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to public_posts_path
    end
  end
end

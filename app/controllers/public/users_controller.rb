class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # ログインユーザーでない場合はアクセスできないようにする。
  before_action :is_matching_login_user, only: [:edit, :update, :destroy, :unsubscribe]
  # ゲストログインユーザーの編集不可とする 2025/04/11
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @user = current_user
    @posts = current_user.posts
  end

  # indexは部分テンプレートのみ（index.html.erbとは別物）なので、今回は実装なし。

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

   # ログインユーザーではない人の編集ができないように制御 2025/04/13
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user), alert: "他のユーザーの情報は編集できません。"
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end 
end

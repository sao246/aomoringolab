class Public::RelationshipsController < ApplicationController
  #コントローラ追加 2025/04/07
  before_action :authenticate_user!
  def create
    # フォロー対象のユーザーを検索（ユーザーIDで）
    user = User.find(params[:user_id])

    if current_user.guest_user?
      redirect_to user_path(user), notice: "ゲストユーザーでのフォローはできません。閲覧のみ可能です。"
    else
      # 今ログインしているユーザー（フォロー処理をしようとしているユーザー）が
      # フォロー（userモデルのfollowメソッド）を呼び出す。
      current_user.follow(user)
      # 元のページへ戻る
      redirect_to request.referer
    end
  end
  
  def destroy
    # フォロー対象のユーザーを検索（ユーザーIDで）
      user = User.find(params[:user_id])
    if current_user.guest_user?
      redirect_to user_path(user), notice: "ゲストユーザーの他ユーザーフォロー解除はできません。フォローを行いたい場合は会員登録をお願いします。"
    else
      # 今ログインしているユーザー（フォロー処理をしようとしているユーザー）が
      # アンフォロー（userモデルのunfollowメソッド）を呼び出す。
      current_user.unfollow(user)
      # 元のページへ戻る
      redirect_to request.referer
    end
  end
  
  def followings
    # 現在見ているユーザーが誰かを特定
    @user = User.find(params[:id])
    # 特定したユーザーがフォローしている人のデータを一式取得
    @owner = User.find(params[:id])
    @users = @owner.followings
  end

  def followers
    # 現在見ているユーザーが誰かを特定
    @user = User.find(params[:id])
    # 特定したユーザーをフォローしている人（フォロワー）のデータを一式取得
    @owner = User.find(params[:id])
    @users = @owner.followers
  end
end

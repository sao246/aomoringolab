class Admin::RelationshipsController < ApplicationController
  def followings
    # 現在見ているユーザーが誰かを特定
    @user = User.find(params[:id])
    # 特定したユーザーがフォローしている人のデータを一式取得
    @users = @user.followings
  end

  def followers
    # 現在見ているユーザーが誰かを特定
    @user = User.find(params[:id])
    # 特定したユーザーをフォローしている人（フォロワー）のデータを一式取得
    @users = @user.followers
  end
end

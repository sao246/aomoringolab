class Public::FavoritesController < ApplicationController
  #コントローラ追加 2025/04/07
    # ユーザーがログインしている場合のみいいね機能を利用できる
    before_action :authenticate_user!
    # @post変数に現在いいね処理の対象となっている投稿(post)情報をセットする。
    before_action :set_post

    def create
      # いいね処理の対象となっている投稿現在のログインユーザーを関連づけていいねレコードを増やす。
      @post.favorites.create(user_id: current_user.id)
      # 失敗した場合は元の画面（リファラー）に戻る
      redirect_back fallback_location: root_path
    end

    def destroy
      # いいね処理の対象となっている投稿にユーザーがいいねしているか確認し情報を取ってくる。
      favorite = @post.favorites.find_by(user_id: current_user.id)
      # ユーザーが投稿にいいねをしている場合は、いいねを解除する
      favorite.destroy if favorite
      # 失敗した場合は元の画面（リファラー）にに戻る
      redirect_back fallback_location: root_path
    end

    private
    def set_post
      @post = Post.find(params[:post_id])
    end
end

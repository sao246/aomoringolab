class Public::FavoritesController < ApplicationController
  #コントローラ追加 2025/04/07
    # ユーザーがログインしている場合のみいいね機能を利用できる
    before_action :authenticate_user!
    # @post変数に現在いいね処理の対象となっている投稿(post)情報をセットする。
    before_action :set_post

    def create
      # ゲストユーザーの処理を制御
      if current_user.guest_user?
        flash[:notice] = "ゲストユーザーでの「いいね」処理は保存されません。"
        # 失敗した場合は元の画面（リファラー）に戻る
        redirect_back fallback_location: root_path
      else
        # いいね処理の対象となっている投稿現在のログインユーザーを関連づけていいねレコードを増やす。
        @post.favorites.create(user_id: current_user.id)
        respond_to do |format|
          format.js
        end
      end
    end

    def destroy
      # ゲストユーザーの処理を制御
      if current_user.guest_user?
        flash[:notice] = "ゲストユーザーでの「いいね」処理は保存されません。"
        # 失敗した場合は元の画面（リファラー）に戻る
        redirect_back fallback_location: root_path
      else
        # いいね処理の対象となっている投稿にユーザーがいいねしているか確認し情報を取ってくる。
        favorite = @post.favorites.find_by(user_id: current_user.id)
        # ユーザーが投稿にいいねをしている場合は、いいねを解除する
        favorite.destroy if favorite
        respond_to do |format|
          format.js
        end
      end
    end

    private
    def set_post
      @post = Post.find(params[:post_id])
    end
end

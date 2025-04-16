class Admin::CommentsController < ApplicationController
  #メソッド内処理追加 2025/04/16
  # ログインしていない人への処理制御
  before_action :authenticate_admin!
  before_action :set_post, only: [:destroy]

  def destroy
    # set_postメソッドを置くので個別のPost.findは実施しない。
    comment = @post.comments.find_by(id: params[:id])
    if comment
      comment.destroy
      redirect_to admin_post_path(params[:post_id]), notice: 'コメントを削除しました。'
    else
      redirect_to admin_post_path(params[:post_id]), alert: 'コメントが見つかりませんでした。'
    end
  end

  def index
    # ビュー呼び出しだけなのでOK。
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end

class Public::CommentsController < ApplicationController
  #コントローラ追加 2025/04/07
  #メソッド内処理追加 2025/04/15
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'コメントしました！'
    else
      render 'public/posts/show', alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find_by(id: params[:id])
    if comment
      comment.destroy
      redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました。'
    else
      redirect_to post_path(params[:post_id]), alert: 'コメントが見つかりませんでした。'
    end
  end

  def index
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

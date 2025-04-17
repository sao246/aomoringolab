class Public::CommentsController < ApplicationController
  #コントローラ追加 2025/04/07
  #メソッド内処理追加 2025/04/15
  def create
    @post = Post.find(params[:post_id])
    # post（投稿）とcomment（コメント）を関連づける。もし、Comment.new(comment_params)だけやってしまうと、Post_id関連付けなしエラーになる。
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'コメントしました！'
    else
      # コメントに関連づけられるユーザー情報を取得する必要あるため、この1文で取得する！なくても稼働する想定だが、DBの効率化のため挿入。
      @comments = @post.comments.includes(:user)
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
    # ビュー呼び出しだけなのでOK。
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

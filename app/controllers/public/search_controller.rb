class Public::SearchController < ApplicationController
  #コントローラ追加 2025/04/07
  before_action :authenticate_user!

  # 検索、検索結果表示用のメソッド追加 2025/04/14
  def index
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    else
      @records = Post.search_for(@content, @method)
    end
  end
end

class Public::SearchController < ApplicationController
  #コントローラ追加 2025/04/07
  before_action :authenticate_user!

  # 検索、検索結果表示用のメソッド追加 2025/04/14
  def index
    # 検索対象のモデルを指定する
    @model = params[:model]
    # 検索するキーワードを設定する変数
    @content = params[:content]
    # 検索方法を指定する（今回は部分一致のみ）
    @method = params[:method]
    if @model == 'post'
      # モデルがPostなら、Postモデルにおいて部分一致でキーワード検索する。
      @records = Post.search_for(@content, @method)
    elsif @model == 'user'
      # モデルがPostなら、Postモデルにおいて部分一致でキーワード検索する。
      @records = User.search_for(@content, @method)
    end
  end
end

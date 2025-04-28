class Admin::SearchController < ApplicationController
  #コントローラ追加 2025/04/16
  # admin権限ログイン者のみ処理可能とする
  before_action :authenticate_admin!

  # 検索、検索結果表示用のメソッド追加 2025/04/14
  def index
    # 検索対象のモデルを指定する
    @model = params[:model]
    # 検索するキーワードを設定する変数
    @content = params[:content]
    # 検索方法を指定する（今回は部分一致のみ）
    @method = params[:method]

    if @model == 'user'
    # モデルがUserなら、Userモデルにおいて部分一致でキーワード検索する。
      @records = User.search_for(@content, @method)
    elsif @model == 'post'
    # モデルがPostなら、Postモデルにおいて部分一致でキーワード検索する。
      @records = Post.search_for(@content, @method)
    end
  end
end

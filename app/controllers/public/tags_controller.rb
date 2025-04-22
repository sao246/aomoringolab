class Public::TagsController < ApplicationController
  #コントローラ追加 2025/04/07
  def index
    @tag = Tag.find_by(name: params[:tag_name])
    if @tag
      @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = []
      flash.now[:alert] = "指定されたタグは存在しません"
    end
  end
end

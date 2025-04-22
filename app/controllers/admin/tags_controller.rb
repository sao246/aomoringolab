class Admin::TagsController < ApplicationController
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

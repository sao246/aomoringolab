Rails.application.routes.draw do

  namespace :public do
    get 'trends/show'
  end
  namespace :public do
    get 'tags/index'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'search/index'
  end
  namespace :public do
    get 'relationships/create'
    get 'relationships/destroy'
    get 'relationships/followers'
    get 'relationships/followings'
  end
  namespace :public do
    get 'post_comments/create'
    get 'post_comments/index'
    get 'post_comments/destroy'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/create'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
  end
  namespace :public do
    get 'users/mypage'
    get 'users/edit'
    get 'users/show'
    get 'users/update'
    get 'users/unsubscribe'
    get 'users/destroy'
    get 'users/favorited_post'
  end
  # Public（エンドユーザー）用のルーティング
  # エンドユーザーのページはコントローラをpublicで管理、URLにはPublicをつけずに管理する。
  scope module: 'public' do
    devise_for :users, controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions',
      passwords: 'public/passwords'
    }
    resources :users, only: [:show, :edit, :update]
    root to: 'homes#top'
    get '/about' => "homes#about"
    get '/feed' => "homes#feed"
  end

  # Admin（管理者）用のルーティング
  # 管理者のページはコントローラもURLも明示的にadminとわかるように管理する。
  namespace :admin do
    devise_for :admins, controllers: {
      sessions: 'admin/sessions'
    }, path: ''
  end
end

Rails.application.routes.draw do

  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
  end

  # Public（エンドユーザー）用のルーティング
  # エンドユーザーのページはコントローラをpublicで管理、URLにはPublicをつけずに管理する。
  scope module: 'public' do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions',
    }
    # resourceの書き方をコントローラに合わせて修正 2025/04/07
    resources :users, only: [:mypage, :edit, :show, :update, :unsubscribe, :destroy, :favorited_post] do
    # 会員の退会処理（unsubscribe）用のルーティング 2025/04/09
      member do
        get 'unsubscribe'
      end
    end
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :post_comments, only: [:create, :index, :destroy]
    resources :relationships, only: [:create, :index, :destroy]
    resources :search, only: [:index]
    resources :favorites, only: [:create, :destroy]
    resources :tags, only: [:index]
    resources :trends, only: [:show]

    root to: 'homes#top'
    get '/about' => "homes#about"
    get '/feed' => "homes#feed"
  end

  # Admin（管理者）用のルーティング
  # 管理者のページはコントローラもURLも明示的にadminとわかるように管理する。
  namespace :admin do
    devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
    }, path: ''
  end
end

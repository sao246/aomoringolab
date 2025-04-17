Rails.application.routes.draw do
  namespace :admin do
    get 'search/index'
  end
  # Public（エンドユーザー）用のルーティング
  # エンドユーザーのページはコントローラをpublicで管理、URLにはPublicをつけずに管理する。
  scope module: 'public' do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions',
    }
    devise_scope :user do
      post '/guest_sign_in', to: 'sessions#guest_sign_in'
    end
    # resourceの書き方をコントローラに合わせて修正 2025/04/07
    resources :users, only: [:edit, :show, :update, :unsubscribe, :destroy, :favorited_post] do
    # 会員の退会処理（unsubscribe）用のルーティング 2025/04/09
      member do
        get 'unsubscribe'
        delete :destroy   # ユーザー削除
      end
    end
    # postsとcommentsコントローラのルーティング見直し 2025/04/15
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :index, :destroy]
    end
    resources :relationships, only: [:create, :index, :destroy]
    resources :search, only: [:index]
    resources :favorites, only: [:create, :destroy]
    resources :tags, only: [:index]
    resources :trends, only: [:show]

    root to: 'homes#top'
    get '/about' => "homes#about"
    get '/feed' => "homes#feed"
    get '/mypage', to: 'users#mypage', as: 'mypage'
  end

  # Admin（管理者）用のルーティング
  # 管理者のページはコントローラもURLも明示的にadminとわかるように管理する。
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }, path: 'admin'
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch :update
      end
    end
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:index, :destroy]
    end
    resources :trends, only: [:index]
    resources :relationships, only: [:create, :index, :destroy]
    resources :search, only: [:index]
    resources :tags, only: [:index]
    get 'homes/top'
  end
end

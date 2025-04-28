Rails.application.routes.draw do
  # Public（エンドユーザー）用のルーティング
  # エンドユーザーのページはコントローラをpublicで管理、URLにはPublicをつけずに管理する。
  scope module: 'public' do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: 'public/registrations',
      sessions: 'public/sessions',
    }
    # ゲストユーザーログイン設定
    devise_scope :user do
      post '/guest_sign_in', to: 'sessions#guest_sign_in'
    end

    # resourceの書き方をコントローラに合わせて修正 2025/04/07
    resources :users, only: [:edit, :show, :update, :destroy, :index] do
      member do
        # 会員の退会処理（unsubscribe）用のルーティング 2025/04/09
        get 'unsubscribe'
        # GET /users/:id/followings と GET /users/:id/followers というパスを作る。
        # 特定のユーザーのフォロー・フォロワー一覧の表示が必要なためmember doに含めてルーティングを行う。
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
      # usersとネストしているのでパスは POST   /users/:user_id/relationships と DELETE /users/:user_id/relationshipsになる
      resource :relationships, only: [:create, :destroy]
    end

    # postsとcommentsコントローラのルーティング見直し 2025/04/15
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :index, :destroy]
      resources :favorites, only: [:create, :destroy]
    end

    resources :search, only: [:index]
    # 名前付きパス：tag/特定のタグ名でURL指定するようにする。
    get 'tags/:tag_name', to: 'tags#index', as: 'tag'
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
        # 特定のユーザーのフォロー・フォロワー一覧の表示が必要なためmember doに含めてルーティングを行う。
        get 'relationships/followings' => 'relationships#followings', as: 'followings'
        get 'relationships/followers' => 'relationships#followers', as: 'followers'
      end
    end
    
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:index, :destroy]
    end

    resources :trends, only: [:index]
    resources :search, only: [:index]
    # 名前付きパス：tag/特定のタグ名でURL指定するようにする。
    get 'tags/:tag_name', to: 'tags#index', as: 'tag'
    get 'homes/top'
  end
end

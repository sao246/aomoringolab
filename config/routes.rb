Rails.application.routes.draw do

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

Rails.application.routes.draw do
  
  root :to => 'public/homes#top'
  
  
  # Admin.routiong
  devise_for :admins, skip: :all #自動routing作成をskip
  # 必要なroutingのみ
  devise_scope :admin do
    get "admins/sign_in" => "admins/sessions#new", as: :new_admin_session 
    post "admins/sign_in" => "admins/sessions#create", as: :admin_session
    delete "admins/sign_out" => "admins/sessions#new", as: :destroy_admin_session
  end
  
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :styles, only: [:index, :create, :edit, :update]
    resources :countries, only: [:index, :create, :edit, :update]
    resources :currencies, only: [:index, :create, :edit, :update]
  end
  
  
  # User.routing
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    # SNSログイン
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  scope module: :public do
    get "/about" => "homes#about"
    get "/account" => "homes#account"
    
    resources :users, only: [:show, :edit, :update]
    # フォロー
    resources :relationships, only: [:create, :destroy]
    # レビュー
    resources :reviews do
       # コメント
      resources :review_comments, only: [:create, :destroy]
    end
    # タグ
    resources :tags
    # 通知
    resources :notifications, only: [:index, :destroy]
    # いいね
    post "like/:id" => "likes#create", as: "create_like"
    delete "like/:id" => "likes#destroy", as: "destroy_like"
    
    # お気に入り
    resources :favorites, only: [:show]
    post "favorite/:id" => "favorites#create", as: "create_favorite"
    delete "favorite/:id" => "favorites#destroy", as: "destroy_favorite"
    
    # お問い合わせ
    get "inquiry" => "inquiry#index"
    post "inquiry/confirm" => "inquiry#confirm"
    post "inquiry/thanks" => "inquiry#thanks"
    
  end
end

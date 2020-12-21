Rails.application.routes.draw do
  
  root :to => 'public/homes#top'
  
  
  # Admin.routiong
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :countries
    resources :genres
    resources :styles
  end
  
  
  # User.routing
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    # SNSログイン
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }
  
  scope module: :public do
    get "/about" => "homes#about"
    get "users/account" => "users#account"
    resources :users, only: [:show, :edit, :update]
    
    # フォロー
    resources :relationships, only: [:create, :destroy]
    
    # レビュー
    resources :reviews do
       # コメント
      resources :review_comments, only: [:create, :destroy]
    end
    
    resources :tags
    
    # googlemaps
    resources :maps, only: [:index]
    
    
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

Rails.application.routes.draw do
  
  root :to => 'pablic/homes#top'
  
  # Admin.route
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
  
  
  # User.route
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  
  scope module: :pablic do
    get "my_page" => "users#my_page"
    resources :users, only: [:show, :edit, :update]
    
    resources :reviews

    # いいね
    post "like/:id" => "likes#create", as: "create_like"
    delete "like/:id" => "likes#destroy", as: "destroy_like"
    
    # お気に入り
    resources :favorites, only: [:show]
    post "favorite/:id" => "favorites#create", as: "create_favorite"
    delete "favorite/:id" => "favorites#destroy", as: "destroy_favorite"
  end
end

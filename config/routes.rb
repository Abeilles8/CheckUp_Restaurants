Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  
  # admin_route
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :countries
    resources :genres
    resources :styles
  end
  
  
  # user_route
  root :to => 'pablic/homes#top'
  scope module: :pablic do
    get "my_page" => "users#my_page"
    resources :users
    resources :reviews
  end
end

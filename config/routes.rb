Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :favorings
      get :favorited_users
      get :likes
    end
  end
  
#    member do
#      get :favorings
#      get :favorited_users
#    end
#  end
  
#  resources :users, only: [:index, :show, :new, :create] do
#    member do
#      get :likes
#    end
#  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
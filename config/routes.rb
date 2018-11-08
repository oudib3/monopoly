Rails.application.routes.draw do
  root 'home#index'
  resources :home, only: [:index]
  resources :sessions, only: [:new, :create]
  resources :games, only: [:index, :create, :update, :destroy] do
    resources :participants, only: [:new, :create, :destroy]
  end
  resources :users, only: [:new,:create, :show]
  resources :games_start, only: [:update]
end
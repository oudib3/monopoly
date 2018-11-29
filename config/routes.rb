Rails.application.routes.draw do
  root 'home#index'
  resources :home, only: [:index]
  resources :sessions, only: [:new, :create]
  resource :sessions, only: [:destroy]

  resources :games, only: [:index, :new, :create, :edit, :update, :destroy] 
  resources :games, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :invitations, only: [:new, :create]
    resources :participants, only: [:new, :create, :destroy]
  end
  resources :users, only: [:new,:create, :show]
  
  resources :games_start, only: [:update]
end
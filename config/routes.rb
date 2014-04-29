StreetEZ::Application.routes.draw do

  root to: "rentals#home"
  
  get "static_pages/about"
  get "static_pages/help"
  
  get 'auth/facebook/callback', to: 'omniauthcallbacks#create'
  
  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]
  
  resource :omniauthcallbacks, only: [:create]

  resources :rentals, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  
  resources :photos, only: [:create, :destroy]
  
  resources :saved_rentals, only: [:create, :destroy]

  resources :messages, only: [:create, :index, :show]
  
  resources :notifications, only: [:index, :show]
  
  resources :open_houses, only: [:create, :destroy]
  
  resources :attend_open_houses, only: [:create, :destroy]
  
  namespace :api, defaults: { format: :json } do
    resources :rentals, only: [:index]
  end
  
end

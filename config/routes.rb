StreetEZ::Application.routes.draw do

  root to: "rentals#home"

  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :rentals, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  
  resources :photos, only: [:create, :destroy]
  
  resources :saved_rentals, only: [:create, :destroy]

  resources :messages, only: [:create, :index, :show]
  
  resources :notifications, only: [:index]

end

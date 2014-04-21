StreetEZ::Application.routes.draw do

  root to: "rentals#home"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :rentals

end

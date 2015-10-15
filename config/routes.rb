Rails.application.routes.draw do
  resources :games
  resources :users
  devise_for :users

  root :to => "home#index"
end

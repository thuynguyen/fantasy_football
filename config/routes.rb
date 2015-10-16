Rails.application.routes.draw do
  resources :games
  resources :users

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
 
  root :to => "users#index"
end

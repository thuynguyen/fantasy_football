Rails.application.routes.draw do
  resources :games do 
  	member do 
  		get :history
      put :join_match
  	end
  	collection do 
    	get :stats
    end
  end
  resources :users
  resources :teams, only: [:show]

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
 
  root :to => "users#index"
end

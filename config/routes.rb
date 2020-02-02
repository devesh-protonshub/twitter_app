Rails.application.routes.draw do

  resources :users do
  	member do
      get :following, :followers
    end
  end
	post 'authenticate', to: 'authentication#authenticate'
	post 'signup', to: 'sessions#signup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

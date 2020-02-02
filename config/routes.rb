Rails.application.routes.draw do

  resources :users do
  	collection do
      get  :followers, :tweets,:user_detail,:followers_tweet 
      post :follow,:unfollow
    end
  end

  resources :tweets do
  	collection do
      post :create_tweet
      delete :destroy_tweet
    end
  end
	post 'authenticate', to: 'authentication#authenticate'
	post 'signup', to: 'sessions#signup'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

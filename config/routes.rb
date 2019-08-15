Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  post '/claim' => "spaces#claim"
  post '/cancel_claim' => "spaces#cancel_claim"
  post '/remove_space' => "spaces#remove_space"
  post '/parked' => "spaces#parked"
  post '/add_space_after_park' => "spaces#add_space_after_park"


  resources :chatrooms, only: [:index, :create, :destroy]
  resources :messages, only: [:create]
  resources :users
  resources :user_spaces
  resources :spaces
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  post "/add_favorites" => "favorites#add_favorites"
  delete "/remove_favorite/:id" => "favorites#remove_favorite"
  post "/login", to: "auth#login"
  post "/provider_login", to: "auth#provider_login"
  get "/auto_login", to: "auth#auto_login"
  post '/claim' => "spaces#claim"
  post '/cancel_claim' => "spaces#cancel_claim"
  post '/remove_space' => "spaces#remove_space"
  post '/parked' => "spaces#parked"
  post "/remove_all", to: "notifications#remove_all"

  resources :notifications, only: [:index, :destroy]
  resources :chatrooms, only: [:index, :create]
  resources :messages, only: [:create]
  resources :users
  resources :space_logs
  resources :spaces
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

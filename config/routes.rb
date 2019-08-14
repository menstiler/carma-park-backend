Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  post 'user_spaces' => "user_spaces#claim"
  post 'user_spaces/cancel_claim' => "user_spaces#cancel_claim"
  post 'user_spaces/parked' => "user_spaces#parked"
  post 'user_spaces/add_space_after_park' => "user_spaces#add_space_after_park"
  post 'user_spaces/remove_space' => "user_spaces#remove_space"

  resources :chatrooms, only: [:index, :create]
  resources :messages, only: [:create]
  resources :users
  resources :user_spaces
  resources :spaces
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'

  resources :users, only: [:update] do
    post :new_wallet, on: :collection
  end
end

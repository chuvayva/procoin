Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'

  resources :users, only: [:update] do
    collection do
      post :new_wallet
      post :balance_sync
    end
  end
end

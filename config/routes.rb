Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get :profile, to: 'users#profile'

  resources :users, only: [:update] do
    post :new_wallet, on: :collection
  end
end

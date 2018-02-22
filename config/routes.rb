Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get :profile, to: 'users#profile'

  #resource :users, only: [:show, :edit, :update] do
    #get :profile, to: 'users#show'
  #end
end

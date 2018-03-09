Rails.application.routes.draw do

  devise_for :users, skip: :invitations

  devise_scope :user do
    resource :invitation, only: :update, path: 'users/invitation', controller: "devise/invitations" do
      get :edit, path: :accept, as: :accept_user
    end
  end

  root to: "home#index"

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'

  resources :users, only: [:update] do
    collection do
      post :new_wallet
      post :balance_sync
    end

    patch :reset_invitation_token
  end

  resources :invitations, only: [:index, :new, :create]

end

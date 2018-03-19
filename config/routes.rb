require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, skip: :invitations

  # Filtered Invitation routes
  # from /devise_invitable-1.7.3/lib/devise_invitable/routes.rb
  devise_scope :user do
    resource :invitation, only: :update, path: 'users/invitation', controller: "devise/invitations" do
      get :edit, path: :accept, as: :accept_user
    end
  end

  root to: "home#index"

  authenticate :user, lambda { |user| Rails.env.development? || user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'

  resources :users, only: [:update] do
    patch :reset_invitation_token
  end

  resources :invitations, only: [:index, :new, :create]

  resource :wallet, only: [:new] do
    post :balance_sync
  end

  resources :transfers, only: [:index, :new, :create]
end

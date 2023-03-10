Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  get 'profile', to: 'common_users#index'

  get 'dashboard', to: 'administrators#index'
  get 'user/new', to: 'administrators#new', as: 'new_user_administration'
  post 'user/create', to: 'administrators#create'
  get 'user/:id/edit', to: 'administrators#edit', as: 'edit_user_administration'

  root 'home#default_home'
end

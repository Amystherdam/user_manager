Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }


  get 'profile', to: 'common_users#index'
  get 'dashboard', to: 'administrators#index'

  root 'home#default_home'
end

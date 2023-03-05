Rails.application.routes.draw do
  devise_for :users

  get 'profile', to: 'common_users#index'
  get 'dashboard', to: 'administrators#index'

  root 'home#path_by_role'
end

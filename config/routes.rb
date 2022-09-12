# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'localhost:3000'
  root 'admin/users#index'
  devise_for :users

  namespace :admin do
    resources :users
  end

  resources :invitations, only: %i[new create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

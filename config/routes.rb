# frozen_string_literal: true

Rails.application.routes.draw do
  root 'admin/users#index'
  devise_for :users

  namespace :admin do
    resources :users
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

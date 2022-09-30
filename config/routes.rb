# frozen_string_literal: true

Rails.application.routes.draw do
  root 'admin/users#index'
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
    resources :orders, only: %i[index]
  end

  namespace :user do
    resources :products, only: [:index]
    resources :carts, only: %i[show destory]
    resources :order_items, only: %i[new create show destroy]
    resources :orders
  end

  post 'payments/create', to: 'payments#create'
  resources :invitations, only: %i[new create]
end

# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'localhost:3000'
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

  post 'order_items/:id/add' => 'order_items#add_quantity', as: 'order_item_add'
  post 'order_items/:id/reduce' => 'order_items#reduce_quantity', as: 'order_item_reduce'

  post 'user/carts/coupon' => 'user/carts#coupon', as: 'carts_coupon'

  resources :invitations, only: %i[new create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

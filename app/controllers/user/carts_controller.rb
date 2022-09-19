# frozen_string_literal: true

# UserNamespace
class User
  # Carts
  class CartsController < ApplicationController
    before_action :current_cart, only: %i[show destroy]
    def show; end

    def destroy
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path
    end
  end
end

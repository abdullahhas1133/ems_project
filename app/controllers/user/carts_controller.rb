# frozen_string_literal: true

# UserNamespace
class User
  # Carts
  class CartsController < ApplicationController
    before_action :current_cart
    def show
      @cart = @current_cart
    end

    def destroy
      @cart = @current_cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path
    end

    def coupon
      value = 0
      value = Coupon.validate_coupon(params[:cart][:coupon]) if params[:cart][:coupon].present?
      # if params[:cart][:coupon].present? & value ==0
      #   flash.now[:notice] = "Invalid Coupon."
      # end
      current_cart.update_attributes(total: current_cart.sub_total - value)
      redirect_to user_cart_path(current_cart)
    end
  end
end

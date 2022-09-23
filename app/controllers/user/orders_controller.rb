# frozen_string_literal: true

# User
class User
  # Class Orders
  class OrdersController < ApplicationController
    before_action :current_cart
    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      value = Coupon.validate_coupon(params[:coupon], current_cart) if params[:coupon].present?
      @coupon = @current_cart.sub_total.to_i - value.to_i
      @order = Order.new
    end

    def create
      @order = current_user.order
      @order.update(order_params)
      @current_cart.order_items.each do |item|
        @order.order_items << item
      end
      @order.save
      redirect_to root_path
    end

    private

    def order_params
      params.require(:order).permit(:first_name, :last_name, :email, :address, :payment, :user_id)
    end
  end
end

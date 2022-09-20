# frozen_string_literal: true

# User namespace
class User
  # OrderItemsController
  class OrderItemsController < ApplicationController
    before_action :current_cart

    def create
      # Find associated product and current cart

      result = CreateOrderItems.call(
        product_id: params[:product_id],
        current_cart: @current_cart,
        current_order: current_order,
      )
      @order_item = result.order_item
      if result.success?
        redirect_to user_cart_path(@current_cart)
      else
        redirect_to user_products_path, alert: 'Error: Could not save to cart'
      end
    end

    def destroy
      @order_item = OrderItem.find(params[:id])
      @order_item.destroy
      redirect_to user_cart_path(@current_cart)
    end

    private

    def current_order
      if session[:order_id].nil? || current_order.nil?
        Order.new
      else
        @order.find(session[:order_id])
      end
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :cart_id, :order_id)
    end
  end
end

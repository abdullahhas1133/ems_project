# frozen_string_literal: true

# Admin
module Admin
  # Class Orders
  class OrdersController < ApplicationController
    before_action :current_cart
    def index
      @orders = Order.all.order(first_name: :desc)
    end
  end
end

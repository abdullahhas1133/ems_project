# frozen_string_literal: true

class User
  # Products_controller
  class ProductsController < ApplicationController
    def index
      @products = Product.all
    end
  end
end

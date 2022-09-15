# frozen_string_literal: true

class User
  class ProductsController < ApplicationController
    before_action :current_cart

    def index
      @products = Product.all
    end
  end
end

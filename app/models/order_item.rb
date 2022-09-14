# frozen_string_literal: true

# OrderItem_model
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
end

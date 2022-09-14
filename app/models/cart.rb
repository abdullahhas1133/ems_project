# frozen_string_literal: true

# Cart_model
class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
end

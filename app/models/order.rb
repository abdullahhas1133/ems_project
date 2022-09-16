# frozen_string_literal: true

# Order_model
class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  enum payment: %i[cash card]
end

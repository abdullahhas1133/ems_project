# frozen_string_literal: true

# Order_model
class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  enum payment: %i[cash card]
  enum status: %i[pending complete]
  validates :first_name, :last_name, :email, :address, presence: true, on: :update
end

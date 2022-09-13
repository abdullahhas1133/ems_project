# frozen_string_literal: true

# Coupon_model
class Coupon < ApplicationRecord
  paginates_per 2

  has_many :products, dependent: :destroy
end

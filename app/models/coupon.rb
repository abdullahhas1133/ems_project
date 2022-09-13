# frozen_string_literal: true

# Coupon_model
class Coupon < ApplicationRecord
  paginates_per 2

  has_many :products, dependent: :destroy

  def self.search(search)
    if search
      where('cast(id as text) LIKE :value or lower(coupons.name) LIKE :value or cast(coupons.value as text) LIKE :value ',
            value: "%#{search.downcase}%")
    else
      all
    end
  end
end

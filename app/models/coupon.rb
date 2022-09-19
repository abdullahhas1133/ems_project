# frozen_string_literal: true

# Coupon_model
class Coupon < ApplicationRecord
  paginates_per 4
  validate :name, :price, presence: true
  has_many :products, dependent: :destroy

  def self.search(search)
    if search
      where('cast(id as text) LIKE :value or lower(coupons.name) LIKE :value or
            cast(coupons.value as text) LIKE :value', value: "%#{search.downcase}%")
    else
      all
    end
  end

  def product_coupon(product_ids)
    product_ids = product_ids.drop(1)
    Product.where(id: product_ids).update_all(coupon_id: id)
  end

  def self.validate_coupon(coupon, cart)
    value = Coupon.find_by(name: coupon).present? ? Coupon.find_by(name: coupon).value : 0

    if value.positive?
      count = cart.products.where('coupon_id = ?', Coupon.find_by(name: coupon).id).count
      value *= count
    end
    value
  end
end

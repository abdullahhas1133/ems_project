# frozen_string_literal: true

# Add CouponRefToProducts
class AddCouponRefToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :coupon
  end
end

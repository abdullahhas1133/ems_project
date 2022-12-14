# frozen_string_literal: true

class AddRefToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :product, foreign_key: true
    add_reference :order_items, :cart, foreign_key: true
  end
end

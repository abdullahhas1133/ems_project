# frozen_string_literal: true

# Create OrderItems
class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
    end
  end
end

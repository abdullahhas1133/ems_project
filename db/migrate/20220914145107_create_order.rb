# frozen_string_literal: true

# Create Order
class CreateOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    end
  end
end

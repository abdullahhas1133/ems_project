# frozen_string_literal: true

# Create Cart
class CreateCart < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
    end
  end
end

# frozen_string_literal: true

# Create Coupons
class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :value
    end
  end
end

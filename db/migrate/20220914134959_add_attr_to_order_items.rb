# frozen_string_literal: true

class AddAttrToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :quantity, :integer
  end
end

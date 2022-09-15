# frozen_string_literal: true

# Add AttrToOrders
class AddAttrToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :text
  end
end

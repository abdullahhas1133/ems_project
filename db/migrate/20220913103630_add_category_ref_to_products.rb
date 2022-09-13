# frozen_string_literal: true

# Add AttributesToUsers
class AddCategoryRefToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, foreign_key: true
  end
end
# frozen_string_literal: true

# Add UserRefToCarts
class AddUserRefToCarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, foreign_key: true
  end
end

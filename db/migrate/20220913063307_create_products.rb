# frozen_string_literal: true

# Create Users
class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.integer :status
    end
  end
end

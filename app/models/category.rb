# frozen_string_literal: true

# Category_model
class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true
end

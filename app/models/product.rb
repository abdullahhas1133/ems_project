# frozen_string_literal: true

# User_model
class Product < ApplicationRecord
  paginates_per 2

  enum status: %i[publish draft pending]

  def self.search(search)
    if search
      where('cast(id as text) LIKE :value or lower(products.title) LIKE :value ',
            value: "%#{search.downcase}%")
    else
      all
    end
  end
end
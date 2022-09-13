# frozen_string_literal: true

require 'csv'
module ExportService
  # class Products_export
  class ProductExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[id title price description status]
      CSV.generate(headers: true) do |csv|
        csv << attributes
        @data.all.each do |product|
          csv << attributes.map { |attr| product.send(attr) }
        end
      end
    end
  end
end

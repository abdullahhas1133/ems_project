# frozen_string_literal: true

require 'csv'
module ExportService
  # class Coupons_export
  class CouponExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[id name value]
      CSV.generate(headers: true) do |csv|
        csv << attributes
        @data.all.each do |user|
          csv << attributes.map { |attr| user.send(attr) }
        end
      end
    end
  end
end

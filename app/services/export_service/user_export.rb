# frozen_string_literal: true

require 'csv'
module ExportService
  # class Users_export
  class UserExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[id email user_name first_name last_name]
      CSV.generate(headers: true) do |csv|
        csv << attributes
        @data.all.each do |user|
          csv << attributes.map { |attr| user.send(attr) }
        end
      end
    end
  end
end

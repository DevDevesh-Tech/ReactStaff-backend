# frozen_string_literal: true

require 'csv'

# To export employees list in csv
class EmployeeCsvExportService
  def initialize(objects)
    @objects = objects
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_headers

      @objects.each do |object|
        csv << csv_row(object)
      end
    end
  end

  private

  def csv_headers
    @objects.first.attributes.keys
  end

  def csv_row(object)
    object.attributes.values
  end
end

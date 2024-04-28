# frozen_string_literal: true

require 'spreadsheet'

# To export employees list in excel formate
class EmployeeExcelExportService
  attr_reader :employees

  def initialize(employees)
    @employees = employees
  end

  def export_to_excel
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet(name: 'Employees')

    # Add headers
    headers = ['ID', 'First Name', 'Last Name', 'Email', 'Contact Number', 'Address', 'Pincode', 'City', 'State',
               'Date of Birth', 'Date of Hiring', 'Created At', 'Updated At']
    sheet.row(0).concat headers

    # Add employee data
    employees.each_with_index do |employee, index|
      sheet.row(index + 1).replace [
        employee.id,
        employee.first_name,
        employee.last_name,
        employee.email,
        employee.contact_number,
        employee.address,
        employee.pincode,
        employee.city,
        employee.state,
        employee.date_of_birth,
        employee.date_of_hiring,
        employee.created_at,
        employee.updated_at
      ]
    end

    # Generate Excel data
    excel_data = StringIO.new
    book.write(excel_data)
    excel_data.string
  end
end

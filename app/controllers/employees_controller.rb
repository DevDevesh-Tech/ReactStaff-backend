# frozen_string_literal: true

# controller to for employees
class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees
  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true)

    respond_to do |format|
      format.html
      format.csv { send_csv_data }
      format.xls { send_excel_data }
    end
  end

  # GET /employees/1
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    redirect_to employees_url, notice: 'Employee was successfully destroyed.'
  end

  def import
    require 'csv'
    file = params[:file]

    CSV.foreach(file.path, headers: true) do |row|
      Employee.create(row.to_h)
    end

    redirect_to employees_path, notice: 'Employees imported successfully'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :contact_number, :address, :pincode,
                                     :city, :state, :date_of_birth, :date_of_hiring)
  end

  def send_csv_data
    csv_data = EmployeeCsvExportService.new(@employees).generate_csv
    send_data csv_data, filename: "employees-#{Date.today}.csv"
  end

  def send_excel_data
    xls_data = EmployeeExcelExportService.new(@employees).export_to_excel
    send_data xls_data, filename: "employees-#{Date.today}.xls"
  end
end

# frozen_string_literal: true

# controller for employees
class Api::V1::EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_employee, only: %i[show update destroy]

  # GET /api/v1/employees
  def index
    @employees = Employee.all
    render json: @employees
  end

  # GET /api/v1/employees/:id
  def show
    render json: @employee
  end

  # POST /api/v1/employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, message: 'Employee created successfully'
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/employees/:id
  def update
    if @employee.update(employee_params)
      render json: @employee, message: 'Employee updated successfully'
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/employees/:id
  def destroy
    @employee.destroy
    render json: { message: 'Employee deleted successfully' }
  end

  def import
    require 'csv'
    file = params[:file]
    if file
      CSV.foreach(file.path, headers: true) do |row|
        Employee.create(row.to_h)
      end
      render json: { message: 'Employee CSV imported successfully' }, status: :ok
    else
      render json: { message: 'No CSV uploaded, please upload a valid CSV file' }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :contact_number, :address, :pincode, :city,
                                     :state, :date_of_birth, :date_of_hiring)
  end
end

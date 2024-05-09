# frozen_string_literal: true

# Searializer to customize the api response
class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :contact_number, :address, :pincode,
             :city, :state, :date_of_birth, :date_of_hiring, :created_at, :updated_at, :full_name, :age
end

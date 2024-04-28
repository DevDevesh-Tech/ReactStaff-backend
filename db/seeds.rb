# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

1000.times do
  Employee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    contact_number: Faker::Number.number(digits: 10),
    address: Faker::Address.street_address,
    pincode: Faker::Address.zip_code,
    city: Faker::Address.city,
    state: Faker::Address.state,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    date_of_hiring: Faker::Date.between(from: 5.years.ago, to: Date.today)
  )
end

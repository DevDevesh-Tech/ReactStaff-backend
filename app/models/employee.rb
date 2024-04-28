# frozen_string_literal: true

# Represents an employee in the company.
class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :contact_number, :date_of_birth, :date_of_hiring, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :contact_number, format: { with: /\A\d{10}\z/, message: 'should be 10 digits' }

  def age
    return nil unless date_of_birth.present?

    current_date = Date.today
    years_old(current_date)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{address}, #{city}, #{state}, #{pincode}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[address city contact_number date_of_birth date_of_hiring email first_name last_name
       pincode state]
  end

  private

  def years_old(current_date)
    age = current_date.year - date_of_birth.year
    age -= 1 if birthday_has_not_passed_yet?(current_date)
    age
  end

  def birthday_has_not_passed_yet?(current_date)
    current_date.month < date_of_birth.month ||
      (current_date.month == date_of_birth.month &&
      current_date.day < date_of_birth.day)
  end
end

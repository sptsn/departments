class Employee < ApplicationRecord
  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true

  has_many :departments, through: :employments
end

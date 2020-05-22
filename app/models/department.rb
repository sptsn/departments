class Department < ApplicationRecord
  validates :formed_at, presence: true

  has_many :employees, through: :employments
end

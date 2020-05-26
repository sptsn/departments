class Employee < ApplicationRecord
  validates :first_name, presence: true
  validates :middle_name, presence: true
  validates :last_name, presence: true

  has_many :departments, through: :employments

  def name
    [first_name, last_name].join(' ')
  end
end

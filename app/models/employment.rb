class Employment < ApplicationRecord
  belongs_to :employee
  belongs_to :department
  validates :start_date, presence: true
  validate :end_date_gteq_start_date
  validate :dates_within_department_dates

  def end_date_gteq_start_date
    return if end_date.blank?

    errors.add(:end_date, 'Must be >= than start date') if start_date > end_date
  end

  def dates_within_department_dates
    if start_date < department.formed_at || (department.disbanded_at.present? && end_date > department.disbanded_at)
      errors.add(:start_date, 'Must be within department dates')
    end
  end
end

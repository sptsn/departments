class Employment < ApplicationRecord
  belongs_to :employee
  belongs_to :department

  validates :start_date, presence: true
  validate :end_date_gteq_start_date
  validate :dates_within_department_dates
  validate :one_department_per_employee

  scope :actual_employees_for_department, -> (department_id, date) { where(department_id: department_id).where('start_date <= ?', date).where('end_date >= ?', date) }

  def end_date_gteq_start_date
    if end_date.present? && start_date > end_date
      errors.add(:end_date, 'Неправильный интервал дат')
    end
  end

  def dates_within_department_dates
    if start_date < department.formed_at || (department.disbanded_at.present? && end_date > department.disbanded_at)
      errors.add(:start_date, 'Даты работы должны совпадать с датами существования отдела')
    end
  end

  def one_department_per_employee
    if self.class.where(employee: employee).where('start_date <= ?', end_date).where('end_date >= ? ', start_date).exists?
      errors.add(:start_date, 'Сотрудник уже работает в заданный период')
    end
  end
end

class DepartmentVersion < ApplicationRecord

  belongs_to :department

  validates :active_since, uniqueness: { scope: :department }
  validate :parent_dates

  scope :actual_at, -> (date) { where('active_since <= ?', date.beginning_of_day) }
  scope :ordered, -> { order(:active_since) }

  delegate :actual_name, to: :department

  def parent_dates
    if ancestry.present? && (parent.formed_at > active_since || parent.disbanded_at.present? && !(parent.formed_at..parent.disbanded_at).include?(active_since))
      errors.add(:active_since, 'должна лежать в пределах периода существования родительского отдела')
    end
  end

  def root?
    ancestry.nil?
  end

  def parent
    Department.find(ancestry)
  end

  def last_version?(date)
    department.versions.actual_at(date).where.not(ancestry: nil).max_by(&:active_since) == self
  end
end

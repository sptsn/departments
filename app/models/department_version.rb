class DepartmentVersion < ApplicationRecord
  # has_ancestry

  belongs_to :department

  validates :active_since, uniqueness: { scope: :department }

  scope :actual_at, -> (date) { where('active_since <= ?', date.beginning_of_day) }
  scope :ordered, -> { order(:active_since) }

  delegate :parent, to: :department

  def name
    read_attribute(:name) || department.name
  end

  def root?
    ancestry.nil?
  end
end

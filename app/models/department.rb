class Department < ApplicationRecord
  has_ancestry

  validates :formed_at, presence: true

  has_many :employees, through: :employments
  has_many :versions, class_name: 'DepartmentVersion'

  def actual_name(date = Date.today)
    versions.actual_at(date).where.not(name: nil).ordered.last&.name || name
  end

  def actual_parent(date = Date.today)
    versions.actual_at(date).where.not(ancestry: nil).ordered.last&.parent || parent
  end

  def actual_children(date = Date.today)
    DepartmentVersion.actual_at(date)
  end

  def actual_version(date = Date.today)
    versions.actual_at(date).ordered.last || self
  end

  def self.actual_roots(date = Date.today)
    roots.map { |r| r.actual_version(date) }.select(&:root?)
  end

  def department_id
    id
  end

  def self.treeview(nodes: actual_roots, date: Date.today)
    nodes.map do |node|
      name = node.is_a?(Department) ? node.actual_name(date) : node.department.actual_name(date)
      employees_count = Employment.where(department_id: node.department_id).where('start_date <= ?', date).where('end_date >= ?', date).count
      {
        text: name,
        nodes: treeview(
          nodes: DepartmentVersion.actual_at(date).where(ancestry: node.department_id.to_s).select { |v| v.department.versions.actual_at(date).where.not(ancestry: nil).max_by(&:active_since) == v},
          date: date
        ),
        tags: ["#{employees_count} сотрудников"],
        data: {
          department_id: node.department_id
        }

        # nodes: treeview(nodes: version&.children || [], date: date)
      }.reject { |_k, v| v.blank? }
    end
  end
end

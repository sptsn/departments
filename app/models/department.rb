class Department < ApplicationRecord
  has_ancestry

  validates :formed_at, presence: true

  has_many :employees, through: :employments
  has_many :versions, class_name: 'DepartmentVersion'

  alias department_id id

  def actual_version(date = Date.today)
    actual_versions(date).last || self
  end

  def actual_name(date = Date.today)
    actual_versions(date).where.not(name: nil).last&.name || name
  end

  def actual_parent(date = Date.today)
    actual_versions(date).where.not(ancestry: nil).last&.parent || parent
  end

  def self.actual_roots(date = Date.today)
    roots.map { |root| root.actual_version(date) }.select(&:root?)
  end

  def self.treeview(nodes, date)
    nodes.map do |node|
      employees_count = Employment.actual_employees_for_department(node.department_id, date).count
      new_nodes = DepartmentVersion.actual_at(date)
                                    .where(ancestry: node.department_id.to_s)
                                    .select { |v| v.last_version?(date) }

      {
        text: node.actual_name,
        nodes: treeview(new_nodes, date),
        tags: ["#{employees_count} сотрудников"],
        data: {
          department_id: node.department_id
        }
      }.reject { |_k, v| v.blank? }
    end
  end

  private

  def actual_versions(date)
    versions.actual_at(date).ordered
  end
end

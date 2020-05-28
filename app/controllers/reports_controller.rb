class ReportsController < ApplicationController
  def index
    if params[:filter].present?
      @departments = Department.all
      date = params[:filter][:date].to_date
      @treeview = Department.treeview(nodes: Department.actual_roots(date), date: date)
    end
  end

  def employees
    @department = Department.find(params[:department_id])
    @employments = Employment.where(department: @department).where('start_date <= ?', params[:date]).where('end_date >= ?', params[:date])

    render partial: 'reports/shared/employees_table'
  end
end

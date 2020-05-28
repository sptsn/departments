class ReportsController < ApplicationController
  def index
    if params[:filter].present?
      @departments = Department.all
      date = params[:filter][:date].to_date
      @treeview = Department.treeview(Department.actual_roots(date), date)
    end
  end

  def employees
    @department = Department.find(params[:department_id])
    @employments = Employment.actual_employees_for_department(params[:department_id], params[:date])

    render partial: 'reports/shared/employees_table'
  end
end

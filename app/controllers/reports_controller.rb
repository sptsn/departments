class ReportsController < ApplicationController
  def index
    if params[:filter].present?
      @departments = Department.all
      date = params[:filter][:date].to_date
      @treeview = Department.treeview(nodes: Department.actual_roots(date), date: date)
    end
  end
end

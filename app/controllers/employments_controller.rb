class EmploymentsController < ApplicationController
  helper_method :employments_collection

  def index; end

  def new
    @employment = Employment.new
  end

  def create
    @employment = Employment.new(params[:employment].permit(:employee_id, :department_id, :start_date, :end_date))

    if @employment.save
      redirect_to employments_path
    else
      render :new
    end
  end

  private

  def employments_collection
    @employments_collection ||= Employment.all
  end
end

class EmployeesController < ApplicationController
  helper_method :employees_collection, :resource_employee

  def index; end

  def new; end

  def create
    if resource_employee.save
      flash[:success] = 'Сотрудник создан'
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if resource_employee.update(employee_params)
      flash[:success] = 'Сотрудник обновлен'
      redirect_to employees_path
    else
      render :edit
    end
  end

  def destroy
    resource_employee.destroy
    flash[:success] = 'Сотрудник удален'
    redirect_to employees_path
  end

  private

  def employees_collection
    @employees_collection ||= Employee.order(id: :desc)
  end

  def resource_employee
    @resource_employee ||= params[:id].present? ? Employee.find(params[:id]) : Employee.new(employee_params)
  end

  def employee_params
    params.fetch(:employee, {}).permit(:first_name, :middle_name, :last_name)
  end
end

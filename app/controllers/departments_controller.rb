class DepartmentsController < ApplicationController
  helper_method :departments_collection

  def index; end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department].permit(:name, :formed_at, :disbanded_at))

    if @department.save
      flash[:success] = 'Отдел сохранен'
      redirect_to departments_path
    else
      render :new
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    if @department.update(params[:department].permit(:formed_at, :disbanded_at))
      flash[:success] = 'Отдел обновлен'
      redirect_to departments_path
    else
      render :edit
    end
  end

  def new_name
    @department = Department.find(params[:department_id])
  end

  def update_name
    @department = Department.find(params[:department_id])

    @version = @department.versions.find_or_initialize_by(active_since: params[:version][:active_since])
    @version.name = params[:version][:name]

    if @version.save
      redirect_to departments_path
    else
      render :new_name
    end
  end

  def new_parent
    @department = Department.find(params[:department_id])
  end

  def update_parent
    @department = Department.find(params[:department_id])

    @version = @department.versions.find_or_initialize_by(active_since: params[:version][:active_since])
    @version.ancestry = params[:version][:department_id]

    if @version.save
      redirect_to departments_path
    else
      render :new_parent
    end
  end

  private

  def departments_params
    params.fetch(:department, {}).permit!
  end

  def departments_collection
    @departments_collection ||= Department.includes(:versions)
  end
end

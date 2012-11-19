class EmployeesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :fetch_employee, only: [:edit, :update, :destroy]

  def new
    @employee = current_user.employees.build
  end

  def create
    @employee = current_user.employees.build(params[:employee])
    if @employee.save
      flash[:notice] = 'New employee has been successfully saved.'
      redirect_to company_path(@employee.company)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update_attributes(params[:employee])
      flash[:notice] = 'Employee has been successfully updated.'
      redirect_to company_path(@employee.company)
    else
      render :edit
    end
  end

  def destroy
    if @employee.destroy
      flash[:notice] = 'Employee has been successfully deleted.'
    end
    redirect_to root_path
  end

  def allow
    @employee = Employee.find(params[:id])
    unless @employee.company.employer.user == current_user
      not_found
    else
      @employee.allow!
      flash[:notice] = 'Employee has been successfully allowed.'
      redirect_to company_path(@employee.company)
    end
  end

  def ban
    @employee = Employee.find(params[:id])
    unless @employee.company.employer.user == current_user
      not_found
    else
      @employee.ban!
      flash[:notice] = 'Employee has been successfully banned.'
      redirect_to company_path(@employee.company)
    end
  end

  protected

  def fetch_employee
    @employee = Employee.find(params[:id])
    not_found unless @employee.user == current_user || @employee.company.employer.user == current_user
  end
end

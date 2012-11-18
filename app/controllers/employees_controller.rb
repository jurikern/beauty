class EmployeesController < ApplicationController
  before_filter :authenticate_user!

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
end

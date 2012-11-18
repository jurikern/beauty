class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:notice] = 'New company has been successfully saved.'
      redirect_to root_path
    else
      render :new
    end
  end
end

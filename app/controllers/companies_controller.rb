class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :fetch_company, only: [:edit, :update, :destroy]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])

    if @company.valid?
      @company.employer = current_user.employer || current_user.create_employer
      @company.save!

      flash[:notice] = 'New company has been successfully saved.'
      redirect_to company_path(@company)
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
    if @company.present?
      @owner = @company.employer.user == current_user
    end
  end

  def edit
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:notice] = 'Company has been successfully updated.'
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def destroy
    if @company.destroy
      flash[:notice] = 'Company has been successdully deleted.'
    end
    redirect_to root_path
  end

  protected

  def fetch_company
    @company = Company.find(params[:id])
    not_found unless @company.employer.user == current_user
  end
end

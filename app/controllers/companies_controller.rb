class CompaniesController < ApplicationController
  before_action :require_owner_or_admin?
  before_action :require_same_user

  def index
    @companies = Company.all.order(name: :asc)
  end

  def new
    @user    = User.find(current_user.id)
    @company = Company.new
  end

  def create
    @user = User.find(current_user.id)
    if @user.companies.create(company_params)
      flash[:success] = "You've just created new company!"
      redirect_to user_companies_path(@user)
    else
      render :new
    end
  end

  def edit
    @user    = User.find(params[:user_id])
    @company = Company.find(params[:id])
  end

  def update
    @user    = User.find(params[:user_id])
    @company = Company.find(params[:id])

    if @company.update(company_params)
      flash[:success] = 'The Company was successfully updated!'
      redirect_to user_companies_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    Company.find(params[:id]).destroy
    redirect_to user_companies_path(@user)
  end

  private

  def company_params
    params.require(:company).permit(:name, :city_id, :price_range, category_ids: [])
  end

end

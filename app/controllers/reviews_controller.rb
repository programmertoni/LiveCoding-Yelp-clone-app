class ReviewsController < ApplicationController
  before_action :require_user, except: [:recent]

  def new
    @user    = User.find(params[:user_id])
    @company = Company.find(params[:company_id])
    @review  = Review.new
  end

  def create
    @user          = User.find(params[:user_id])
    @company       = Company.find(params[:company_id])
    @review         = Review.new(review_params)
    @review.user    = @user
    @review.company = @company

    if @review.save
      flash[:success] = 'You have successfully created Review.'
      redirect_to reviews_user_path(current_user)
    else
      flash[:danger] = 'You have to mark star and write a comment up to 300 characters!'
      redirect_to new_user_company_review_path(@user, @company)
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def listed_companies
    @companies = Company.all
  end

  def recent
  end

  private

  def review_params
    params.require(:review).permit(:stars, :content)
  end

end

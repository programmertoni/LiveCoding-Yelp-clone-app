class CategoriesController < ApplicationController
  before_action :require_admin, except: [:show]

  def index
    @categories = Category.all.order(title: :asc)
  end

  def show
    @current_category = Category.find(params[:id])
    @companies        = @current_category.companies
  end

  def new
    @current_category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = 'Category was successfuly added!'
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @current_category = Category.find(params[:id])
  end

  def update
    @current_category = Category.find(params[:id])

    if @current_category.update(category_params)
      flash[:success] = "Category was successfuly updated!"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Category was successfuly deleted'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end

class CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @categories = Category.all.order(title: :asc)
  end

  def new
    @category = Category.new
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
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
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

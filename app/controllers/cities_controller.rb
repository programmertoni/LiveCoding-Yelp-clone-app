class CitiesController < ApplicationController
  before_action :require_admin

  def index
    @cities = City.list_all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      flash[:success] = 'City was successfuly added!'
      redirect_to cities_path
    else
      render :new
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])

    if @city.update(city_params)
      flash[:success] = "City was successfuly updated!"
      redirect_to cities_path
    else
      render :edit
    end
  end

  def destroy
    City.find(params[:id]).destroy
    flash[:success] = 'City was successfuly deleted'
    redirect_to cities_path
  end

  private

  def city_params
    params.require(:city).permit(:name, :country)
  end

end

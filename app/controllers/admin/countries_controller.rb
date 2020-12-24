class Admin::CountriesController < ApplicationController
   
   before_action :authenticate_admin!
   
  def index
    @country = Country.new
    @countries = Country.all.page(params[:page]).per(10)
  end
  
  def create
    @country = Country.new(country_params)
    @country.save
    redirect_to admin_countries_path
  end
  
  def edit
    @country = Country.find(params[:id])
  end
  
  def update
    @country = Country.find(params[:id])
    @country.update(country_params)
    redirect_to admin_countries_path(@country)
  end
  
  private
  def country_params
    params.require(:country).permit(:name, :currency, :is_active, :created_at, :updated_at)
  end
end

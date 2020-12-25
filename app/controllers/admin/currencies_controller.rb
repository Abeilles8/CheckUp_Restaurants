class Admin::CurrenciesController < ApplicationController
  
  before_action :authenticate_admin!
   
  def index
    @currency = Currency.new
    @currencies = Currency.all.page(params[:page]).per(10)
  end
  
  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      redirect_to admin_currencies_path
    else
      @currencies = Currency.all.page(params[:page]).per(10)
      render :index
    end
  end
  
  def edit
    @currency = Currency.find(params[:id])
  end
  
  def update
    @currency = Currency.find(params[:id])
    if @currency.update(currency_params)
      redirect_to admin_currencies_path(@currency)
    else
      render :edit
    end
  end
  
  private
  def currency_params
    params.require(:currency).permit(:name, :is_active, :created_at, :updated_at)
  end
end

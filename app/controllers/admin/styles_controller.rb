class Admin::StylesController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @style = Style.new
    @styles = Style.all.page(params[:page]).per(10)
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      redirect_to admin_styles_path
    else
      @styles = Style.all.page(params[:page]).per(10)
      render :index
    end
  end
  
  def edit
    @style = Style.find(params[:id])
  end
  
  def update
    @style = Style.find(params[:id])
    if @style.update(style_params)
      redirect_to admin_styles_path(@style)
    else
      render :edit
    end
  end
  
  private
  def style_params
    params.require(:style).permit(:name, :is_active, :created_at, :updated_at)
  end
end

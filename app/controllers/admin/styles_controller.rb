class Admin::StylesController < ApplicationController
  
  def index
    @style = Style.new
    @styles = Style.all
  end
  
  def create
    @style = Style.new(style_params)
    @style.save
    redirect_to admin_styles_path
  end
  
  def edit
    @style = Style.find(params[:id])
  end
  
  def update
    @style = Style.find(params[:id])
    @style.update(style_params)
    redirect_to admin_styles_path(@style)
  end
  
  private
  def style_params
    params.require(:style).permit(:name, :is_active, :created_at, :updated_at)
  end
end

class Pablic::UsersController < ApplicationController
  # before_action :set_user, only: [:show]
  # current_user => my_page
  # before_action :authenticate_user!, only: [:my_page]
  
  def my_page
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to my_page_path, notice: "更新しました"
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:my_country, :email, :profile_image, :introduction)
  end
  
  # def set_user
  #   @user = User.find([:id])
  # end
end
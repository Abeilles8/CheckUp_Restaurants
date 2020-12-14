class Pablic::UsersController < ApplicationController
  # before_action :set_user, only: [:show]
  # current_user => my_page
  # before_action :authenticate_user!, only: [:my_page]
  
  def my_page
    @reviews = Review.all
  end
  
  def show
    @user = User.find(params[:id])
    # my_pageには自分がレビューしたものだけを表示
    @reviews = @user.reviews.all
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path, notice: "更新しました"
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:my_country, :email, :image, :introduction)
  end
  
end
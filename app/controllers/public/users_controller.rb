class Public::UsersController < ApplicationController
  # before_action :set_user, only: [:show]
  # current_user => my_page
  # before_action :authenticate_user!, only: [:my_page]
  
  
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
    redirect_to user_path, notice: "プロフィールを更新しました"
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:my_country, :email, :image, :introduction)
  end
  
end
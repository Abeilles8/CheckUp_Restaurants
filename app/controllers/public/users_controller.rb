class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    # my_pageには自分がレビューしたものだけを表示
    @reviews = @user.reviews.all.order("created_at DESC")
    # 総いいね数
    @user_reviews = @user.reviews
    @likes_count = 0
    @user_reviews.each do |review|
      @likes_count += review.likes.count
    end
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:update] = "プロフィールを更新しました"
    redirect_to user_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :my_country, :email, :image, :introduction)
  end
end
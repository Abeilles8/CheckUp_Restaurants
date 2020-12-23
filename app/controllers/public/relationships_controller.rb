class Public::RelationshipsController < ApplicationController
  
  before_action :set_user
  
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = "フォローしました"
      # 通知機能
      # @user.create_notification_follow!(current_user)
      redirect_to @user
    else
      flash[:notice] = "フォローに失敗しました"
      redirect_to @user
    end
  end
  
  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = "フォローを解除しました"
      redirect_to @user
    else
       flash[:notice] = "フォローの解除に失敗しました"
      redirect_to @user
    end
  end
  
  private
  def set_user
    @user = User.find(params[:follow_id])
  end
end


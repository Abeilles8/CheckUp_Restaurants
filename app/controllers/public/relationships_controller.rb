class Public::RelationshipsController < ApplicationController
  
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = "フォローしました"
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
  def
    @user = User.find(params[:relationship][:follow_id])
  end
end


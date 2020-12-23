class Public::LikesController < ApplicationController
  
  # いいね
  def create
    @review = Review.find(params[:review_id])
    Like.create(user_id: current_user.id, review_id: params[:id])
    # 通知機能
    @review.create_notification_like!(current_user)
    redirect_back(fallback_location: root_path)
  end
  
  # いいねを外す
  def destroy
    # find_byで複数検索
    likes =  Like.find_by(user_id: current_user.id, review_id: params[:id])
    likes.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  # ユーザーがクリックしたレビュー
  def clicked_review
    Review.find(params[:review_id])
  end
end

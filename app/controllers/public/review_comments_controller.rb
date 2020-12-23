class Public::ReviewCommentsController < ApplicationController
  
  def create
    # review = Review.find(params[:review_id])
    @comment = current_user.review_comments.new(review_comment_params)
    @comment.review_id = params[:review_id]
    if @comment.save
      flash[:primary] = "コメントを送信しました"
      # 通知機能
      # @review = @comment.review
      # @review.create_notification_comment?(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      comments_get
      flash[:danger] = "コメントの送信に失敗しました"
      render "public/reviews/show"
    end
  end
  
  def destroy
    ReviewComment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    flash[:danger] = "コメントを削除"
    redirect_back(fallback_location: root_path)
  end
  
  private
  def review_comment_params
    params.require(:review_comment).permit(:comment, :user_id, :review_id)
  end
end

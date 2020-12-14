class Public::ReviewCommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = review.id
    comment.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    ReviewComment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  def review_comment_params
    params.require(:review_comment).permit(:comment, :user_id, :review_id)
  end
end

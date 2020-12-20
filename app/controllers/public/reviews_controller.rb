class Public::ReviewsController < ApplicationController
  # ログインユーザーのみ
	before_action :authenticate_user!, only: [:show]
	
	def index
	  @reviews = Review.all
	end
  
  def new
  	@review = Review.new
  # 	@review.spot.builds
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
    	redirect_to review_path(@review.id), notice: "投稿しました"
    else
      render :new
    end
  end
  
  def show
    @review = Review.find(params[:id])
    # コメント
    @review_comment = ReviewComment.new
    # GoogleMaps
    gon.review = @review
  end
  
  def edit
    @review = Review.find(params[:id])
    if @review.user == current_user
      render :edit
    else
      redirect_to reviews_path
    end
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review.id), notice: "投稿を更新しました"
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.delete
    redirect_to reviews_path
    
  end
  
  def search
    @reviews = Review.search(params[:search])
  end
  
  private
  def review_params
  	params.require(:review).permit(
  	  :name, 
  	  :rate, 
  	  { :review_images_images => []}, 
  	  :content, 
  	  :address, 
  	  :budget, 
  	  :user_id, 
  	  :country_id, 
  	  :style_id, 
  	  { :genre_ids => [] },
  	  )
  end
end

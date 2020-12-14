class Pablic::ReviewsController < ApplicationController
  # ログインユーザーのみ
	before_action :authenticate_user!
	
	def index
	  @reviews = Review.all
	end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
  	@review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save!
    	redirect_to reviews_path, notice: "投稿しました"
    else
      render :new
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review.id), notice: "更新しました"
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.delete
    redirect_to reviews_path
    
  end
  
  private
  def review_params
  	params.require(:review).permit(:name, :rate, :image, :content, :budget, :user_id, :country_id, :style_id, :genre_id)
  end
end

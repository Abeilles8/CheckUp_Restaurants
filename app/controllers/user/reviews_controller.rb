class User::ReviewsController < ApplicationController
	
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
  	@review.save
  	redirect_to review_path(@review.id)
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review.id)
  end
  
  def destroy
  end
  
  private
  def review_params
  	params.require(:review).permit(:name, :rate, :image, :content, :budget)
  end
end

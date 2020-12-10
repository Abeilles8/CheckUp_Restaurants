class User::ReviewsController < ApplicationController
	
	def index
  end
  
  def show
  end
  
  def new
  	@review = Review.new
  end
  
  def create
  	@review = Review.new(review_params)
  	@review.save
  	redirect_to review_path(params[])
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def review_params
  	params.require(:review).permit(:name, :rate, :image, :content, :budget)
  end
end

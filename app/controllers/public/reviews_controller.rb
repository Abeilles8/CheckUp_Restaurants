class Public::ReviewsController < ApplicationController
	
  # 	ログインユーザーのみ
  before_action :authenticate_user!
  # before_action :baria_review
	
	def index
	  @reviews = Review.all.order("created_at DESC").page(params[:page]).per(4)
	  
	  if params[:tag_name]
	   # tagged_withで絞り込み
	    @reviews = Review.tagged_with("#{params[:tag_name]}")
	  end
	end
  
  def new
  	@review = Review.new
  # 	@review.spot.builds
  end
  
  def create
    @review = Review.new(review_params)
    # 送信された値をスペースで区切って配列化
    # tag_list = params[:review][:tag_name].split(nil)
    @review.user_id = current_user.id
    if @review.save
      # 取得したタグの配列をdbに保存
      # @review.save_tag(tag_list)
      flash[:primary] = "投稿しました"
    	redirect_to review_path(@review.id)
    else
      flash[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  def show
    @review = Review.find(params[:id])
    # コメント
    @review_comment = ReviewComment.new
    # GoogleMaps
    gon.review = @review
    # タグ
    # @review_tags = @review.tags
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
    if @review.update(review_params)
      flash[:update] = "投稿を更新しました"
      redirect_to review_path(@review.id)
    else
      flash[:danger] = "投稿の更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.delete
    flash[:danger] = "投稿を削除"
    redirect_to reviews_path
  end
  
  # def search
  #   @tag_list = Tag.all
  #   @tag = Tag.find(params[:tag_id])
  #   @reviews = @tag.reviews.all
  # end
  
  private
  def review_params
  	params.require(:review).permit(
  	  :name, 
  	 # :rate, 
  	  { :review_images_images => []}, 
  	  :content, 
  	  :address, 
  	  :budget, 
  	  :user_id, 
  	  :country_id,
  	  :style_id, 
  	  { :genre_ids => [] },
  	  :tag_list,
  	 # review_images_attributes: [:image, :id]
  	  )
  end
  
  # def baria_review
  #   unless Review.find(params[:id]).user_id == current_user.id
  #     # 元のページに
  #     redirect_back(fallback_location: root_path)
  #   end
  # end
end

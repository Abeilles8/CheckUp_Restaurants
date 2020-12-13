class Pablic::FavoritesController < ApplicationController
  
  # お気に入り
  def create
    Favorite.create(user_id: current_user.id, review_id: params[:id])
    redirect_back(fallback_location: root_path)
  end
  
  # お気に入りを外す
  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, review_id: params[:id])
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end

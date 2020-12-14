class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  
  
  
  # いいね
  def liked_by?(review_id)
    # whereでlikesテーブルにreview_idがあるか検索する
    likes.where(review_id: review_id).exists?
  end
  
  # お気に入り
  def favorited_by?(review_id)
    favorites.where(review_id: review_id).exists?
  
  end

end

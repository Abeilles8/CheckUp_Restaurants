class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  def liked_by?(review_id)
    # whereでlikesテーブルにreview_idがあるか検索する
    likes.where(review_id: review_id).exists?
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter, :google_oauth2, :github]
         
  attachment :image
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :sns
  
  has_many :relationships
  # relationshipsテーブルのfollow_idを参考に、followings(架空)モデルにアクセスする
  has_many :followings, through: :relationships, source: :follow
  # relationshipsテーブルにアクセスする時は、follow_idを入口にアクセスする
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  # reverse_of_relationshipsからuser_idを出口に自分をフォローしているuserを持ってくる
  has_many :followers, through: :reverse_of_relationships, source: :user
  

  # フォロー
  def follow(other_user)
    # フォローしようとしているother_userが自分自信ではないか確認する
    unless self == other_user
      # 見つかればRelationを返し、見つからなければフォロー関係を保存する
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
    
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    # relationshipが存在したらdestroy
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    # self.followingsでフォローしているUserを取得、include?(other_user)でother_userが含まれていないか確認
    self.followings.include?(other_user)
  end
  
  
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

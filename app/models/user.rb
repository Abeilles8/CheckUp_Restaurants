class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :google_oauth2, :github]
         
  attachment :image
  has_many :sns_credentials, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",  foreign_key: "visited_id", dependent: :destroy
  
  has_many :relationships
  # relationshipsテーブルのfollow_idを参考に、followings(架空)モデルにアクセスする
  has_many :followings, through: :relationships, source: :follow
  # relationshipsテーブルにアクセスする時は、follow_idを入口にアクセスする
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  # reverse_of_relationshipsからuser_idを出口に自分をフォローしているuserを持ってくる
  has_many :followers, through: :reverse_of_relationships, source: :user
  

  # フォロー機能
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
  # /フォロー機能
  
  # 通知機能<フォロー>
  def create_notification_follow?(current_user)
    # 既に通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end
  
  # いいね機能
  def liked_by?(review_id)
    # whereでlikesテーブルにreview_idがあるか検索する
    likes.where(review_id: review_id).exists?
  end
  
  # お気に入り機能
  def favorited_by?(review_id)
    favorites.where(review_id: review_id).exists?
  end
  
  
end

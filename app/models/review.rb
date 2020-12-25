class Review < ApplicationRecord
	
	belongs_to :user
	belongs_to :country
	belongs_to :style
	
	has_many :likes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :review_comments, dependent: :destroy
	has_many :notifications, dependent: :destroy
	
	has_many :review_genres, dependent: :destroy
	# articles経由でgenreにアクセス
	has_many :genres, through: :review_genres
	
	has_many :review_images, dependent: :destroy
	
	# image
	accepts_attachments_for :review_images, attachment: :image
	# まとめて保存する
	# accepts_nested_attributes_for :review_images, allow_destroy: true
	attachment :image
	
	# tag付け
	acts_as_taggable

	# addressカラムを基準に緯度経度を算出する
	geocoded_by :address
	# 住所変更時に緯度経度も変更する
	after_validation :geocode, if: :address_changed?
	
	
	def self.search(search)
		return Review.all unless search
		Review.where(['content LIKE ?', "%#{search}%"])
	end
	
	# 通知機能<いいね>
	def create_notification_like?(current_user)
		# 既に通知が作成されているか確認
		temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ?",
																current_user.id, user_id, id, "like"])
		if temp.blank?
			notification = current_user.active_notifications.new(
				review_id: id,
				visited_id: user_id,
				action: "like"
			)
				
			# 登録済み、自分の投稿にいいねの場合通知を確認済みにする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			
			notification.save if notification.valid?
		end
	end
	
	# 通知機能<コメント>
	def create_notification_comment?(current_user, review_comment_id)
		# 同じ投稿にコメントしているユーザーに通知（current_userと投稿者は除いて）
		#  distinctで複数コメントしていても通知は一件
		temp_ids = ReviewComment.where(review_id: id).where.not("user_id = ? or user_id", current_user.id, user_id).select(:user_id).distinct
		# 取得したuser_idをユーザー達に通知を作成（user_idのみ繰り返し取得）
		temp_ids.each do |temp_id|
			save_notication_comment!(current_user, review_comment_id, temp_id["user_id"])
		end
		# 投稿者へ通知を作成
		save_notication_comment!(current_user, review_comment_id, user_id)
	end
	
	def save_notication_comment!(current_user, review_comment_id, visited_id)
		notification = current_user.active_notifications.new(
			review_id: id,
			review_comment_id: comment_id,
			visited_id: visited_id,
			action: "comment"
		)
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
	# /通知機能<コメント>
	
	# validation
	with_options presence: true do
		validates :review_images_images, :name, :country_id, :address
	end
	# 整数かつ0以上で
	validates :budget, numericality: { allow_nil: true, :greater_than_or_equal_to => 0 }
end

class Review < ApplicationRecord
	
	belongs_to :user
	belongs_to :country
	belongs_to :style
	
	has_many :likes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :review_comments, dependent: :destroy
	
	has_many :review_genres, dependent: :destroy
	# articles経由でgenreにアクセス
	has_many :genres, through: :review_genres
	
	has_many :review_images, dependent: :destroy
	
	# tag付け
	# has_many :tag_maps, dependent: :destroy
	# has_many :tags, through: :tag_maps
	
	acts_as_taggable

	accepts_attachments_for :review_images, attachment: :image
	attachment :image
	
	# addressカラムを基準に緯度経度を算出する
	geocoded_by :address
	# 住所変更時に緯度経度も変更する
	after_validation :geocode, if: :address_changed?
	
	
	def self.search(search)
		return Review.all unless search
		Review.where(['content LIKE ?', "%#{search}%"])
	end
	
	# タグ機能
	# def save_tag(sent_tags)
	# 	# 現在存在するタグを取得
	# 	current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
	# 	# 古いタグを取得
	# 	old_tags = current_tags - sent_tags
	# 	# 新しいタグを取得
	# 	new_tags = sent_tags - current_tags
		
	# 	# 古いタグを削除
	# 	old_tags.each do |old|
	# 		self.review_tags.delete Tag.find_by(tag_name: old)
	# 	end
		
	# 	# 新しいタグを保存
	# 	new_tags.each do |new|
	# 		new_review_tag = Tag.find_or_create_by(tag_name: new)
	# 		self.tags << new_review_tag
	# 	end
		
	# end
	
	
	validates :name, presence: true
	validates :review_images_images, presence: true
	
end

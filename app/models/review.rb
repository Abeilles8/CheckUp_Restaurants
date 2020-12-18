class Review < ApplicationRecord
	
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :review_comments, dependent: :destroy
	# has_one :spot, dependent: :destroy
	# accepts_nested_attributes_for :spot
	
	has_many :review_genres, dependent: :destroy
	# articles経由でgenreにアクセス
	has_many :genres, through: :review_genres
	belongs_to :country
	belongs_to :style

	attachment :image
	# addressカラムを基準に緯度経度を算出する
	geocoded_by :address
	# 住所変更時に緯度経度も変更する
	after_validation :geocode, if: :address_changed?
	
end

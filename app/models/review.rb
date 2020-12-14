class Review < ApplicationRecord
	
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :review_comments, dependent: :destroy
	
	belongs_to :country
	belongs_to :style
	belongs_to :genre
	
end

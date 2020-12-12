class Review < ApplicationRecord
	
	belongs_to :user
	has_many :likes
	
	belongs_to :country
	belongs_to :style
	belongs_to :genre
	
end

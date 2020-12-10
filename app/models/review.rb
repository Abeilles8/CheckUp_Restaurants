class Review < ApplicationRecord
	
	belongs_to :user
	belongs_to :country
	belongs_to :style
	belongs_to :genre
	
end

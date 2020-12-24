class Genre < ApplicationRecord
	
	has_many :review_genres
	# articles経由でreviewにアクセス
	has_many :reviews, through: :review_genres
	attachment :image
	
	
	# validates :name, presence: true
end

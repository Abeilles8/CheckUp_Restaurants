class Genre < ApplicationRecord
	
	has_many :reviews
	attachment :image
end

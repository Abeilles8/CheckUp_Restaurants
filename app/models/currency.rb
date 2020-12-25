class Currency < ApplicationRecord
  
  has_many :reviews
	
	validates :name, presence: true
end

class ReviewImage < ApplicationRecord
  
  belongs_to :review, optional: true
  
  attachment :image
end

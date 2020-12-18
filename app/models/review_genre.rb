class ReviewGenre < ApplicationRecord
  
  belongs_to :review, optional: true
  belongs_to :genre, optional: true
end

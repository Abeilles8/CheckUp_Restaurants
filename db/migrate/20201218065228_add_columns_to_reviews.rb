class AddColumnsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :address, :string
    add_column :reviews, :latitude, :float
    add_column :reviews, :longitude, :float
  end
end

class AddCurrencyIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :currency_id, :integer
  end
end

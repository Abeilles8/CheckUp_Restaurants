class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :review, foreign_key: true, null: false
      
      t.timestamps
      # unique制約で重複を防ぐ
      t.index [:user_id, :review_id], unique: true
    end
  end
end

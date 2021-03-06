class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      
      t.timestamps
      
      # unique制約で重複を防ぐ
      t.index [:user_id, :review_id], unique: true
    end
  end
end

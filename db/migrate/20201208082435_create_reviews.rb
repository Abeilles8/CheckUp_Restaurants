class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :country_id
      t.integer :style_id
      t.integer :genre_id
      t.string :name
      t.float :rate
      t.string :image_id
      t.text :content
      t.integer :budget
       
      t.timestamps
    end
  end
end

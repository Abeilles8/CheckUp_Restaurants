class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :name
      t.float :rate
      t.string :image
      t.text :content
      t.integer :budget
       
      t.timestamps
    end
  end
end

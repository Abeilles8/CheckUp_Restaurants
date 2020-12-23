class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      # to_tableオプションで参照先を指定
      # 通知を送るユーザー
      t.references :visitor, foreign_key:{ to_table: :users }, null: false
      # 通知を受け取るユーザー
      t.references :visited, foreign_key:{ to_table: :users }, null: false
      t.references :review, foreign_key: true
      t.references :review_comment, foreign_key: true
      
      t.string :action, null: false
      t.boolean :checked, default: false, null: false
      
      t.timestamps
    end
    
  end
end

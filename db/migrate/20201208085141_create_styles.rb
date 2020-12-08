class CreateStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :styles do |t|
      t.string :style_name
      t.boolean :is_active, default: false, null: false

      t.timestamps
    end
  end
end

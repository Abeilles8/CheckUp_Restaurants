class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name
      t.boolean :is_active, default: true, null: false
      
      t.timestamps
    end
  end
end

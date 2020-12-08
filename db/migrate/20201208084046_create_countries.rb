class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :country_name
      t.string :currency
      t.boolean :is_active, default: true, null: false
      
      t.timestamps
    end
  end
end
class RemoveCurrencyFromCountries < ActiveRecord::Migration[5.2]
  def change
    remove_column :countries, :currency, :string
  end
end

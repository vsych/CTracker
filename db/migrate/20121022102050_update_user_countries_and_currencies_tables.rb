class UpdateUserCountriesAndCurrenciesTables < ActiveRecord::Migration
  def self.up
    remove_column :user_countries, :country_id
    remove_column :user_currencies, :currency_id
    add_column :user_countries, :country_code, :string
    add_column :user_currencies, :currency_code, :string

    add_index :user_countries, [:user_id, :country_code], :unique => true
    add_index :user_currencies, [:user_id, :currency_code], :unique => true
  end

  def self.down
    remove_index :user_countries, [:user_id, :country_code]
    remove_index :user_currencies, [:user_id, :currency_code]

    remove_column :user_countries, :country_code
    remove_column :user_currencies, :currency_code
    add_column :user_countries, :country_id, :integer
    add_column :user_currencies, :currency_id, :integer
  end
end

class CreateUserCountries < ActiveRecord::Migration
  def self.up
    create_table :user_countries, :id => false do |t|
      t.integer :user_id
      t.integer :country_id
    end
  end

  def self.down
    drop_table :user_countries
  end
end

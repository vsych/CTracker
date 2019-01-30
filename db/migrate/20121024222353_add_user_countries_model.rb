class AddUserCountriesModel < ActiveRecord::Migration
  def self.up
    remove_index "user_countries", ["user_id", "country_code"]
    drop_table :user_countries

    create_table :user_countries do |t|
      t.column :country_code, :string
      t.column :user_id, :integer

      t.timestamps
    end

    add_index :user_countries, [:country_code, :user_id]
  end

  def self.down
    remove_index :user_countries, [:country_code, :user_id]
    drop_table :user_countries

    create_table :user_countries do |t|
      t.integer :user_id
      t.integer :country_code
    end

    add_index "user_countries", ["user_id", "country_code"]
  end
end

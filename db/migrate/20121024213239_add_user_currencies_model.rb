class AddUserCurrenciesModel < ActiveRecord::Migration
  def self.up
    remove_index "user_currencies", ["user_id", "currency_id"]
    drop_table :user_currencies

    create_table :user_currencies do |t|
      t.column :currency_code, :string
      t.column :user_id, :integer

      t.timestamps
    end

    add_index :user_currencies, [:currency_code, :user_id]
  end

  def self.down
    remove_index :user_currencies, [:currency_code, :user_id]
    drop_table :user_currencies

    create_table :user_currencies, :id => false do |t|
      t.integer :user_id
      t.integer :currency_id
    end

    add_index "user_currencies", ["user_id", "currency_id"]
  end
end

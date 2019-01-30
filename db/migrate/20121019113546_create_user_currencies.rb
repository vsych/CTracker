class CreateUserCurrencies < ActiveRecord::Migration
  def self.up
    create_table :user_currencies, :id => false do |t|
      t.integer :user_id
      t.integer :currency_id
    end
  end

  def self.down
    drop_table :user_currencies
  end
end

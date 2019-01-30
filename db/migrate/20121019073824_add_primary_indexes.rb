class AddPrimaryIndexes < ActiveRecord::Migration
  def self.up
    add_index :countries, :code, :unique => true
    add_index :currencies, :code, :unique => true
  end

  def self.down
    remove_index :countries, :code
    remove_index :currencies, :code
  end
end

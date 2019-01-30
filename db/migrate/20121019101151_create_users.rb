class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :email, :string, :limit => 50
      t.column :encrypted_password, :string, :limit => 250
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

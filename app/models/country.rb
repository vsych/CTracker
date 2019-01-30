class Country < ActiveRecord::Base
  set_primary_key :code

  has_many :currencies
  has_many :user_countries
  has_many :users, :through => :user_coutries

  attr_accessible :name, :code

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  accepts_nested_attributes_for :currencies, :allow_destroy => true
end

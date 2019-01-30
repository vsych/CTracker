class Currency < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code, :country_id

  belongs_to :country
  has_many :user_currencies
  has_many :users, :through => :user_currencies

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  def self.collected
    all.select {|currency| currency.collected? }
  end

  def self.not_collected
    all.reject {|currency| currency.collected? }
  end

  def collected?
    country.nil? ? false : country.visited?
  end
end

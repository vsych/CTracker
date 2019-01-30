class User < ActiveRecord::Base

  has_many :user_currencies
  has_many :currencies, :through => :user_currencies

  has_many :user_countries
  has_many :countries,
           :through => :user_countries,
           :before_add => :add_all_currencies_of_country,
           :before_remove => :remove_all_currencies_of_country

  attr_accessor :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation

  before_save :encrypt_password

  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => {:minimum => 5}, :on => :create, :confirmation => true

  def toggle_visiting(country)
    if visited?(country)
      countries.delete(country)
    else
      countries << country
    end
  end

  def visited?(country)
    self.countries.exists?(country)
  end

  def update_collection(currency)
    if collect?(currency)
      currencies.delete(currency)
      update_country_visiting(currency.country)
    else
      currencies << currency
      single_collecting do
        self.countries << currency.country unless visited?(currency.country)
      end
    end
  end

  def collect?(currency)
    currencies.exists?(currency)
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(self.password, password_salt)
      self.password = ""
    end
  end

  def add_all_currencies_of_country(country)
    self.currencies << country.currencies unless @single_collecting
  end

  def remove_all_currencies_of_country(country)
    self.currencies.delete(*country.currencies)
  end

  def single_collecting &block
    @single_collecting = true
    block.call
    @single_collecting = false
  end

  def update_country_visiting(country)
    all_currencies = country.currencies
    if (all_currencies & self.currencies).empty? && visited?(country)
      toggle_visiting(country)
    end
  end

end

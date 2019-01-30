class Session
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :email, :password

  def initialize(params = {})
    self.email, self.password = params[:email], params[:password]
  end

  def persisted?
    false
  end

  validate :credentials

  def user
    @user ||= User.find_by_email(self.email)
  end

  private

  def credentials
    unless user.present? && user.encrypted_password == BCrypt::Engine.hash_secret(self.password, user.password_salt)
      errors.add(:base, "Not valid credentials")
    end
  end
end

class UserCountry < ActiveRecord::Base
  self.include_root_in_json = false
  belongs_to :user
  belongs_to :country, :foreign_key => :country_code

  validates :user, :presence => true, :allow_blank => false
  validates :country, :presence => true, :allow_blank => false

  scope :user_statistic, lambda{ |user| where(:user_id => user.id).
      select("strftime( '%Y-%m-%d', created_at) as date, count(*) as cnt").
      group("date") }
end

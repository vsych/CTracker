# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user1 = User.find_or_create_by_email("user1@example.com", :password => "Password123!")
puts """
You could login as user1
email:    user1@example.com
password: Password123!
---------------------------
"""

user2 = User.find_or_create_by_email("user2@example.com", :password => "Password123!")
puts """
You could login as user2
email:    user2@example.com
password: Password123!
---------------------------
"""

countries = Country.where("code in (?)", ["af", "ar", "gb", "an", "ht", "mt", "vu"])

countries.each do |country|
  user1.toggle_visiting(country)
end

puts "-- Faking data"
start_time = Date.today - 8.days
ucs = UserCountry.where(:user_id => user1.id).all
1.upto(7) do |t|
  date = start_time + t.days
  uc = ucs.shift()
  uc.update_attributes({:created_at, date, :updated_at, date})


  uc.country.currencies.map do |c|
    UserCurrency.where(:user_id => user1.id, :currency_code => c.code).map do |c|
      c.update_attributes({:created_at, date, :updated_at, date})
    end
  end
end
puts "-- Done"

Given /^Exists one country with two currencies$/ do
  @country = Country.create(:name => "CountryOne", :code => "c_one")
  @currency1 = Currency.create(:name => "CurrencyOne", :code => "cc_one")
  @currency2 = Currency.create(:name => "CurrencyTwo", :code => "cc_two")
  @country.currencies << @currency1 << @currency2
end

When /^list of countries exists$/ do
  step "I am logged in"
  %w{1 2 3}.each do |n|
    Country.create(:name => "Country#{n}", :code => "c#{n}")
  end
end

Then /^I should see table with countries$/ do
  visit countries_path
  page.should have_content("Country1")
  page.should have_content("Country2")
  page.should have_content("Country3")
end

When /^I check country as visited$/ do
  visit countries_path
  @code = "c1"
  within("table#collection") do
    find(:xpath, "//input[@type='checkbox' and @id='country_#{@code}']").set(true)
  end
end

Then /^status of country should change to "Visited"$/ do
  find(:xpath, "//tr[@id='record_#{@code}']//td[@class='status']").should have_content("Visited")
end

When /^I check country as not visited$/ do
  @country = Country.first
  @user.countries << @country
  visit countries_path
  within("table#collection") do
    find(:xpath, "//input[@type='checkbox' and @id='country_#{@country.code}']").set(false)
  end
end

Then /^status of country should change to "Not Visited"$/ do
  find(:xpath, "//tr[@id='record_#{@country.code}']//td[@class='status']").should have_content("Not Visited")
end

When /^I open country detials page$/ do
  step "I am logged in"
  step "Exists one country with two currencies"
  visit country_path(@country.code)
end

Then /^I should see list of currencies available in this country$/ do
  page.should have_content(@currency1.name)
  page.should have_content(@currency2.name)
end

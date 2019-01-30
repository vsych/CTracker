When /^list of currencies exists$/ do
  step "I am logged in"
  step "Exists one country with two currencies"
end

Then /^I should see table with them$/ do
  visit currencies_path
  page.should have_content(@currency1.name)
  page.should have_content(@currency2.name)
end

When /^I want to look on currency closed$/ do
  step "list of currencies exists"
  visit currency_path(@currency1)
end

Then /^I open currency detail page$/ do
  page.should have_content(@country.name)
  page.should have_content(@currency1.code)
  page.should have_content(@currency1.name)
end

When /^I mark one the currencies as collected$/ do
  visit currencies_path
  @code = @currency1.code
  within("table#collection") do
    find(:xpath, "//input[@type='checkbox' and @id='currency_#{@code}']").set(true)
  end
end

Then /^its status changed to "Collected"$/ do
  find(:xpath, "//tr[@id='record_#{@code}']//td[@class='status']").text.should eq("Collected")
end

When /^I mark one the currencies as not collected$/ do
  @user.currencies << @currency1
  visit currencies_path
  @code = @currency1.code
  within("table#collection") do
    find(:xpath, "//input[@type='checkbox' and @id='currency_#{@code}']").set(false)
  end
end

Then /^its status changed to "Not Collected"$/ do
  find(:xpath, "//tr[@id='record_#{@code}']//td[@class='status']").text.should eq("Not Collected")
end

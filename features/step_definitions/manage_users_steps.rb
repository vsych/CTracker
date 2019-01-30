Given /^I am not logged in$/ do
  visit root_path
  click_link "Logout" if page.has_content?("Logout")
end

Then /^I open home page$/ do
  visit root_path
end

When /^I should see login form$/ do
  page.should have_xpath("//form//input[@name='session[email]']")
  page.should have_xpath("//form//input[@name='session[password]']")
end

When /^Page should not contain links to "Currencies" and "Countries"$/ do
  page.should_not have_xpath("//nav//a[text()='Currencies']")
  page.should_not have_xpath("//nav//a[text()='Countries']")
end

# TODO rewrite
Given /^I am logged in$/ do
  password = "Password123!"
  @user = User.create(:email => "one888@example.com", :password => password)
  visit new_session_path
  within("form") do
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => password
    click_button "Login"
  end
end

When /^I should see "Currencies" and "Countries" links$/ do
  page.should have_xpath("//nav//a[text()='Currencies']")
  page.should have_xpath("//nav//a[text()='Countries']")
  page.should_not have_xpath("//nav//a[text()='Login']")
  page.should have_xpath("//nav//a[text()='Logout']")
end

Then /^I fill invalid credentials$/ do
  visit new_session_path
  within("form.new_session") do
    fill_in "Email", :with => "not valid email"
    fill_in "Password", :with => "not valid password"
    click_button "Login"
  end
end

When /^I should see error message$/ do
  page.should have_content("Not valid credentials")
end

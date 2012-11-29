Given /^I am logged in as an administrator$/ do
  @admin = FactoryGirl.create(:user, email: "admin@habitbuild.com")
  @admin.add_role :admin
  @visitor ||= { :email => "admin@habitbuild.com", :password => "please", :password_confirmation => "please" }
  sign_in
end

When /^I visit the users page$/ do
  visit users_path
end

Then /^I should see a list of users$/ do
  page.should have_content @user[:email]
end

Then /^I should see an access denied message$/ do
  page.should have_content "Not authorized as an administrator"
end

Given 'I am on $page_name' do |page_name|
  visit path_to page_name
end

When 'I click "$text"' do |text|
  click_on text
end

When 'I fill in the following:' do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

When 'I go to $page_name' do |page_name|
  visit path_to page_name
end

Then 'I should not be able to get to $page_name' do |page_name|
  path = path_to page_name
  begin
    visit path
    expect(current_path).not_to be == path
  rescue Pundit::NotAuthorizedError
    # don't worry about it
  end
end

Then /^I should (not )?be on (.+)$/ do |negation, page_name|
  expect(current_path == path_to(page_name)).to be == !negation
end

Then(/^I should (not )?see "([^"]*)"$/) do |negation, text|
  to_or_not = negation ? :not_to : :to
  expect(page).public_send to_or_not, have_text(text)
end

Then 'I should see the following:' do |table|
  table.raw.flatten.each do |string|
    expect(page).to have_text string
  end
end

Then 'I should see the value "$value" in the "$field" field' do |value, field|
  expect(page.find_field(field).value).to be == value
end

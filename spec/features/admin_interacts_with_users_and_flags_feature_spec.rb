require 'rails_helper'

feature 'Admin interacts with users and flags feature' do

  background do
    set_and_login with: 'Admin Toni', as: 'admin'
  end

  scenario 'Admin logs in' do
    user_clicks_through_users_feature
    user_clicks_through_flags_feature_and_checks_for_company_search_form
  end

  private

  def user_clicks_through_users_feature
    click_link 'Account Settings'
    click_link 'All Users'
    expect(page).to have_content('Admin Toni')
    click_link 'mail'
    expect(page).to have_content('Admin Toni')
    click_link 'Back'
    expect(page).to have_content('Admin Toni')
  end

  def user_clicks_through_flags_feature_and_checks_for_company_search_form
    click_link 'Flags'
    expect(page).to have_content('Review Flags')
    expect(page).to have_selector("input[type=submit][value='Search']")
    click_link 'Log Out'
    expect(page).to have_no_selector("input[type=submit][value='Search']")
    expect(page).to have_no_content('Search')
  end
end

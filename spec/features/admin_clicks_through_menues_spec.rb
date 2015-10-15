require 'rails_helper'

feature 'Admin clicks through the App' do
  scenario 'Admin logs in' do
    set_and_login with: 'Admin Toni', as: 'admin'
    check_if_main_menu_is_working
    check_if_left_menu_is_working
  end

  private

  def check_if_main_menu_is_working
    click_link 'Home'
    expect(page).to have_content('Welcome!')
    click_link 'Write a review'
    expect(page).to have_content('Write a Review')
    click_link 'Find Friends'
    expect(page).to have_content('Find User')
    click_link 'Messages'
    expect(page).to have_content('My Messages')
    click_link 'About us'
    expect(page).to have_content('No us just me.')
    click_link 'Help'
    expect(page).to have_content('This app is really easy to use if you know how the real Yelp app works.')
    fill_in 'name', with: 'Addidas'
    click_button 'Search'
    expect(page).to have_content('Search results')
  end

  def check_if_left_menu_is_working
    click_link 'About me'
    expect(page).to have_content('You have no Reviews')
    click_link 'Settings'
    expect(page).to have_content('My Settings')
    click_link 'My Friends'
    expect(page).to have_content('Friends (0)')
    click_link 'Pending (0)'
    expect(page).to have_content('Pending (0)')
    click_link 'Blocked (0)'
    expect(page).to have_content('Blocked (0)')
    click_link 'My Companies'
    expect(page).to have_content('You have no Companies listed')
    click_link 'Add new Company'
    expect(page).to have_content('€€ (for rich people)')
    click_link 'All Cities'
    expect(page).to have_content('Yelp clone app')
    click_link 'Add new City'
    expect(page).to have_content('Yelp clone app')
    click_link 'All Categories'
    expect(page).to have_content('Yelp clone app')
    click_link 'Add new Category'
    expect(page).to have_content('Yelp clone app')
    click_link 'Log Out'
    expect(page).to have_content('You are logged out. We hope to see you soon!')
    expect(page).to have_no_content('About me')
    expect(page).to have_no_content('Write a review')
    expect(page).to have_no_content('Find Friends')
    expect(page).to have_no_content('Messages')
  end
end

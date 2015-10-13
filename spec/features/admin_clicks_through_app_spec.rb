require 'rails_helper'

feature 'Admin clicks through the App' do

  background do
    admin = User.create(full_name: 'Admin Toni', password: 'password', role: 'user')
    admin.update(role: 'admin')
  end

  scenario 'Admin logs in' do
    visit root_path
    click_link 'Login'
    fill_in 'Full Name', with: 'Admin Toni'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Hello Admin Toni! You are logged in.')

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
  end

end

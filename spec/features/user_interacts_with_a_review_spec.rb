require 'rails_helper'

feature 'User adds, edits a review' do

  background do
    @owner   = User.create(full_name: 'Owner', password: 'password', role: 'owner')
    @city    = City.create(name: 'Ljubljana', country: 'Slovenia')
    @company = Company.create(name: 'Big Company', price_range: 3, user_id: @owner.id, city_id: @city.id)
  end

  scenario 'Signs in with correct credentials' do
    set_and_login with: 'User Toni', as: 'user'
    create_a_review
    edit_review
  end

  scenario 'Signs in with incorect credentials' do
    visit root_path
    click_link 'Login'
    fill_in 'Full Name', with: 'User Toni'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('There was something wrong with your Full Name or Password!')
  end

  private

  def create_a_review
    click_link 'Write a review'
    expect(page).to have_content('Write a Review for listed Companies below')
    find("#company-#{@company.id}").click
    expect(page).to have_content('New Review')
    choose('star4')
    fill_in 'review_content', with: 'My First review!'
    click_button 'Save'
    expect(page).to have_content('My First review!')
  end

  def edit_review
    click_link 'Edit'
    expect(page).to have_content("for #{@company.name}")
    choose('star5')
    fill_in 'review_content', with: 'MY First edit.'
    click_button 'Save'
    expect(page).to have_content('MY First edit.')
  end
end

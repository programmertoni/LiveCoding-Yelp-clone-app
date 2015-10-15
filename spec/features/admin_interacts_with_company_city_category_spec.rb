require 'rails_helper'

feature 'Admin interacts with company city and category' do
  given(:city) do
    City.create(name: 'Ljubljana', country: 'Slovenia')
  end

  scenario 'Admin creates and updates a company' do
    city #creates city
    set_and_login with: 'Admin Toni', as: 'admin'
    admin_adds_a_company
    admin_edits_the_company
  end

  scenario 'Admin creates and updates a city' do
    set_and_login with: 'Admin Toni', as: 'admin'
    admin_adds_new_city
    admin_edits_city_name
  end

  scenario 'Admin creates and updates a category' do
    set_and_login with: 'Admin Toni', as: 'admin'
    admin_adds_new_category
    admin_edits_a_category
  end

  private

  def admin_adds_a_company
    click_link 'About me'
    click_link 'My Companies'
    expect(page).to have_content('You have no Companies listed')
    click_link 'Create your First Company'
    expect(page).to have_content('Add new Company')
    fill_in 'Name', with: 'Tonko & Balonko co.'
    select 'Ljubljana',      from: 'City'
    select '€ (for anyone)', from: 'Price range'
    click_button 'Add Company'
    expect(page).to have_content("You've just created new company!")
  end

  def admin_edits_the_company
    click_link 'Edit'
    expect(page).to have_content('Edit Company')
    fill_in 'Name', with: 'Balonko & Tonko'
    click_button 'Save'
    expect(page).to have_content('The Company was successfully updated!')
  end

  def admin_adds_new_city
    click_link 'About me'
    click_link 'Add new City'
    fill_in 'City',    with: 'Ljubljana'
    fill_in 'Country', with: 'Slovenia'
    click_button 'Add City'
    expect(page).to have_content('City was successfuly added!')
    expect(page).to have_content('Ljubljana')
  end

  def admin_edits_city_name
    click_link 'edit'
    expect(page).to have_content('Edit City')
    fill_in 'City', with: 'Paris'
    click_button 'Save'
    expect(page).to have_content('City was successfuly updated!')
    expect(page).to have_content('Paris')
  end

  def admin_adds_new_category
    click_link 'About me'
    click_link 'Add new Category'
    fill_in 'Title', with: 'Restaurant'
    click_button 'Add Category'
    expect(page).to have_content('Restaurant')
  end

  def admin_edits_a_category
    click_link 'edit'
    expect(page).to have_content('Restaurant')
    fill_in 'Title', with: 'Food & Drink'
    click_button 'Save'
    expect(page).to have_content('Food & Drink')
  end
end

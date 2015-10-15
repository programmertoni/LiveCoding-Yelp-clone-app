require 'rails_helper'

feature 'user interact with friends feature' do
  given!(:friend) do
    User.create(full_name: 'Friend Jakob', password: 'password', role: 'user')
  end

  scenario 'User find a friend and adds him as a friend' do

    set_and_login with: 'User Toni', as: 'user'
    user_searches_for_friend
    user_sends_requst_to_friend_and_logs_out

    friend_logs_in
    friend_checks_for_pending_friendships
    friend_sends_user_a_message

    user_logs_in
    user_reads_friend_message_and_marks_it_important

  end

  private

  def user_searches_for_friend
    click_link 'Find Friends'
    expect(page).to have_content('Find User')
    fill_in 'find-friend-form', with: 'Jakob'
    find('#find-friend-button').click
    expect(page).to have_content('Friend Jakob')
  end

  def user_sends_requst_to_friend_and_logs_out
    click_link 'Friend Request'
    expect(page).to have_content('Friend request was successfully sent!')
    click_link 'Log Out'
    expect(page).to have_content('You are logged out. We hope to see you soon!')
  end

  def friend_logs_in
    click_link 'Login'
    expect(page).to have_content('Log in')
    fill_in 'Full Name', with: 'Friend Jakob'
    fill_in 'Password',  with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Hello Friend Jakob! You are logged in.')
  end

  def friend_checks_for_pending_friendships
    click_link 'About Me'
    click_link 'My Friends'
    expect(page).to have_content('Pending (1)')
    click_link 'Pending (1)'
    click_link 'Accept'
    expect(page).to have_content('Friends (1)')
  end

  def friend_sends_user_a_message
    click_link 'Friends (1)'
    expect(page).to have_content('Toni')
    click_link 'send mail'
    expect(page).to have_content('New Message for User Toni')
    fill_in 'Title',   with: 'Hello old friend'
    fill_in 'Content', with: 'Can we meet laer today?'
    click_button 'Send'
    expect(page).to have_content('Message was sent!')
    click_link 'Log Out'
    expect(page).to have_content('You are logged out. We hope to see you soon!')
  end

  def user_logs_in
    click_link 'Login'
    fill_in 'Full Name', with: 'User Toni'
    fill_in 'Password',  with: 'password'
    click_button 'Log in'
  end

  def user_reads_friend_message_and_marks_it_important
    click_link 'Messages'
    expect(page).to have_content('unread (1)')
    click_link 'Hello old friend'
    expect(page).to have_content('Can we meet laer today?')
    click_link 'important'
    expect(page).to have_content('unimportant')
  end
end

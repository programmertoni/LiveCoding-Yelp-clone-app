def set_and_login(options={})
  name = options[:with]
  role = options[:as]

  if role == 'admin'
    user = User.create(full_name: name, password: 'password', role: 'user')
    user.update(role: 'admin')
  else
    user = User.create(full_name: name, password: 'password', role: role)
  end

  visit root_path
  click_link 'Login'
  fill_in 'Full Name', with: name
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  expect(page).to have_content("Hello #{name}! You are logged in.")
end


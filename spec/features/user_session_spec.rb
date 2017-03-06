require 'rails_helper'

describe 'user authentication process', :type => :feature do
  context 'when a user is not yet registered' do
    it 'registers a user' do
      visit '/register'

      fill_in 'Chefname', with: 'Chef Moses'
      fill_in 'Email', with: 'chef@example.com'
      fill_in 'Password', with: 'password1'

      click_button 'Register'
      expect(page).to have_content 'Your account has been created successfully'
      expect(page).to have_content 'Chef moses'
    end
  end

  context 'when a user is already registered' do
    before :each do
      Chef.create(chefname: 'Delicious D', email: 'chef@example.com', password: 'password1')
    end

    it 'logs a user in' do
      user_logs_in
    end

    it 'logs out a user' do
      user_logs_in

      click_link 'Logout'
      expect(page).to have_content 'You have logged out'
    end

    def user_logs_in
      visit '/login'

      fill_in 'Email', with: 'chef@example.com'
      fill_in 'Password', with: 'password1'

      click_button 'Login'
      expect(page).to have_content 'You are logged in'
    end
  end
end
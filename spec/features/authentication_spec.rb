require 'rails_helper'

describe 'Authentication', type: :feature do
  let!(:user) { FactoryGirl.create(:user, name: 'testuser')}

  describe 'Logging in' do
    before do
      visit '/login'
    end

    context 'when name and password are correct' do
      before do
        fill_in 'Name', with: 'testuser'
        fill_in 'Password', with: 'password'
        click_button 'Login'
      end

      it 'logs the user in' do
        expect(page).to have_content 'Welcome'
      end
    end

    context 'when login form is blank' do
      before do
        click_button 'Login'
      end

      it 'rejects the login' do
        expect(page).to have_content 'Invalid user/password combination'
      end
    end

    context 'when name is wrong' do
      before do
        fill_in 'Name', with: 'user'
        fill_in 'Password', with: 'password'
        click_button 'Login'
      end

      it 'rejects the login' do
        expect(page).to have_content 'Invalid user/password combination'
      end
    end

    context 'when password is wrong' do
      before do
        fill_in 'Name', with: 'testuser'
        fill_in 'Password', with: 'password1'
        click_button 'Login'
      end

      it 'rejects the login' do
        expect(page).to have_content 'Invalid user/password combination'
      end
    end
  end
  
  describe 'Logging out' do
    before do
      visit '/login'
      fill_in 'Name', with: 'testuser'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    context 'when the user clicks the Logout button' do
      before do
        click_button 'Logout'
      end

      it 'logs out the user' do
        expect(page).not_to have_content 'Orders'
        expect(page).not_to have_content 'Products'
        expect(page).not_to have_content 'Users'
      end
    end
  end
end

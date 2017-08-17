require 'rails_helper'

describe 'Users Navigation', type: :feature do
  describe 'Creating Users' do
    before do
      visit '/users/new'
    end

    context 'when the form is valid' do
      before do
        fill_in 'Name', with: 'testuser'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Save'
      end

      it 'creates the user' do
        expect(page).to have_content 'User testuser was successfully created'
      end
    end

    context 'when the form is invalid' do
      context 'and the form is blank' do
        before do
          click_button 'Save'
        end

        it 'returns an error page' do
          expect(page).to have_content "Name can't be blank"
          expect(page).to have_content "Password can't be blank"
        end
      end

      context 'and password does not match password_confirmation' do
        before do
          fill_in 'Name', with: 'testuser'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password1'
          click_button 'Save'
        end

        it 'returns an error page' do
          expect(page).to have_content "Password confirmation doesn't match Password"
        end
      end

      context 'and the name chosen already exists' do
        let!(:user) { FactoryGirl.create(:user, name: 'testuser') }

        before do
          fill_in 'Name', with: 'testuser'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Save'
        end

        it 'returns an error page' do
          expect(page).to have_content 'Name has already been taken'
        end
      end
    end
  end
end

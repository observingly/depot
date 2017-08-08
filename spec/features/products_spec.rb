require 'rails_helper'

describe 'product page navigation', type: :feature do
  describe 'Product Creation' do
    it "creates a product" do
      visit '/products'
      click_link 'New Product'
      fill_in 'Title', with: 'Cup'
      fill_in 'Description', with: 'This is a good cup'
      fill_in 'Image url', with: 'http://test.com/wat.jpg'
      fill_in 'Price', with: '200'
      click_button 'Create Product'

      expect(page).to have_content 'Product was successfully created'
    end
  end
end

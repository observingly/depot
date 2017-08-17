require 'rails_helper'

describe 'Checkout Process', type: :feature do
  describe 'Cart Page' do
    context 'when there are products in the store' do
      let!(:product) { FactoryGirl.create(:product, title: 'Ticketbase') }

      before do
        visit '/'
        click_button 'Add to Cart'
      end

      it 'displays the products in the cart' do
        expect(page).to have_content 'Ticketbase'
      end

      it 'displays the quantity of the product' do
        expect(page).to have_content '1 ×'
      end

      it 'displays the total of the cart' do
        expect(page).to have_content 'Total P5.00'
      end

      context 'and the user presses the Empty Cart button', js: true do
        before do
          click_button 'Empty cart'
          page.driver.accept_js_confirms!
        end

        it 'empties the cart' do
          expect(page).to have_content 'Cart was successfully emptied'
        end
      end
    end

    context 'when there are multiple products in the store' do
      let!(:product) { FactoryGirl.create(:product, title: 'Ticketbase1') }
      let!(:product2) { FactoryGirl.create(:product, id: 123, title: 'Ticketbase2') }

      before do
        visit '/'
        find_button(id: 'product123').click
      end

      it 'displays the products in the cart' do
        expect(page).to have_content 'Ticketbase2'
      end
    end
  end

  describe 'Checkout Page' do
    let!(:product) { FactoryGirl.create(:product, title: 'Shirt') }
    context 'when user has no line items' do
      before do
        visit '/orders/new'
      end

      it 'redirects to the home page' do
        expect(page).to have_content 'Your cart is empty'
      end
    end

    context 'when user has line items' do
      before do
        visit '/'
        click_button 'Add to cart'
        click_button 'Checkout'
        fill_in 'Name', with: 'Test User'
        fill_in 'Address', with: 'Test Address'
        fill_in 'Email', with: 'test@example.com'
        select 'Purchase order', from: 'Pay type'
        click_button 'Place Order'
      end

      it 'places and order' do
        expect(page).to have_content 'Thank you for your order'
      end

      it 'sends an email' do
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end
  end
end

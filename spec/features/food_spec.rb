require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
  before :each do
    @user = User.new(name: 'Marial', email: 'marial@gmail.com', password: '123456')
    @food = Food.new(name: 'Tomato', measurement_unit: 'kg', price: 5, quantity: 1, user: @user)
  end

  describe 'food#index page' do
    it 'Should display the food index page after signing up the user' do
      visit root_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      click_link 'Sign up'
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      click_button 'Sign up'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Foods')
      click_link 'Add food'
      expect(page).to have_current_path(new_food_path)
      fill_in 'food[name]', with: @food.name
      fill_in 'food[measurement_unit]', with: @food.measurement_unit
      fill_in 'food[price]', with: @food.price
      fill_in 'food[quantity]', with: @food.quantity
      click_button 'Create Food'
      expect(page).to have_content('Food Information')
      visit root_path
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
      visit root_path
      click_link 'Delete'
      expect(page).not_to have_content(@food.name)
    end
  end
end

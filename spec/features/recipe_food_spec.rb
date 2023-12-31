require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'RecipeFoods', type: :feature do
  before :each do
    @user = User.new(name: 'Sona', email: 'sona@gmail.com', password: '123456')
    @food = Food.new(name: 'Tomato', measurement_unit: 'kg', price: 5, quantity: 1, user: @user)
    @recipe = Recipe.new(name: 'Beryani', description: 'Onion', preparation_time: 1, cooking_time: 2, user: @user)
    @recipe_food = RecipeFood.new(quantity: 2, food: @food, recipe: @recipe)
  end
  describe 'recipe_food#index page' do
    it 'Should display the recipe_food or ingredients index page for a logged in user' do
      visit root_path
      click_link 'Sign up'
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      click_button 'Sign up'
      click_link 'Add food'
      fill_in 'food[name]', with: @food.name
      fill_in 'food[measurement_unit]', with: @food.measurement_unit
      fill_in 'food[price]', with: @food.price
      fill_in 'food[quantity]', with: @food.quantity
      click_button 'Create Food'
      visit recipes_path
      click_link 'Add Recipe'
      fill_in 'recipe[name]', with: @recipe.name
      fill_in 'recipe[preparation_time]', with: @recipe.preparation_time
      fill_in 'recipe[cooking_time]', with: @recipe.cooking_time
      fill_in 'recipe[description]', with: @recipe.description
      click_button 'Create Recipe'
      visit recipes_path
      click_link @recipe.name
      click_link 'Add ingredient'
      fill_in 'recipe_food[quantity]', with: @recipe_food.quantity
      select @food.name, from: 'recipe_food[food_id]'
      click_button 'Add ingredient'
      visit recipes_path
      click_link @recipe.name
      expect(page).to have_content(@recipe_food.quantity)
      expect(page).to have_content((@recipe_food.quantity * @food.price).to_s)
    end
  end
end
# rubocop:enable Metrics/BlockLength

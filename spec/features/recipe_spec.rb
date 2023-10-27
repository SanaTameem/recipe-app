require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  before :each do
    @user = User.new(name: 'Marial', email: 'marial@gmail.com', password: '123456')
    @recipe = Recipe.new(name: 'Beryani', description: 'Onion , Rice, Tomato and yougurt are needed',
                         preparation_time: 1, cooking_time: 2, user: @user)
  end

  describe 'recipe#index page' do
    it 'Should display the recipe index page for a logged in user' do
      visit recipes_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      click_link 'Sign up'
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      click_button 'Sign up'
      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content('Recipes List')
      click_link 'Add Recipe'
      expect(page).to have_current_path(new_recipe_path)
      fill_in 'recipe[name]', with: @recipe.name
      fill_in 'recipe[preparation_time]', with: @recipe.preparation_time
      fill_in 'recipe[cooking_time]', with: @recipe.cooking_time
      fill_in 'recipe[description]', with: @recipe.description
      click_button 'Create Recipe'
      visit recipes_path
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
      click_link 'Delete'
      expect(page).not_to have_content(@recipe.name)
    end
  end
end

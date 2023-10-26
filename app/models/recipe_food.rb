class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :food, uniqueness: { scope: :recipe, message: 'Only one recipe is allow for the same food' }
end

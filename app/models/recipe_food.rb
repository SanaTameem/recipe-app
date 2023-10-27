class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :food, uniqueness: { scope: :recipe, message: 'Only one recipe is allow for the same food' }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

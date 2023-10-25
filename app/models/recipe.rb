class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  has_many :recipe_foods, foreign_key: 'recipe_id'
  validates :name, :preparation_time, :cook_time, :description, presence: true
  :public
end

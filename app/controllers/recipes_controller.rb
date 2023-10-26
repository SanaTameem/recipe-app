class RecipesController < ApplicationController
  load_and_authorize_resource

  # before_action :set_recipe, only: %i[show destroy]
  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to food_path(@recipe), notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @foods = Food.all
    @recipe = Recipe.find(params[:id])
    @recipe
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path
    else
      render 'new'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)

    respond_to(&:js)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
class Api::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  around_action :log_time
  def index
    recipe = Recipe.all.order(created_at: :desc)
    render json: recipe
  end

  def create
    recipe = Recipe.create!(recipe_params)
    if recipe
      render json: recipe
    else
      render json: recipe.errors
    end
  end

  def show
    render json: @recipe
  end

  def destroy
    @recipe&.destroy
    render json: { message: 'Recipe deleted!' }
  end

  private

  def recipe_params
    params.permit(:name, :image, :ingredients, :instruction)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def log_time
    start_time = Time.now
    yield  # This runs the actual action
    end_time = Time.now
    puts "Action took #{end_time - start_time} seconds."
  end
end

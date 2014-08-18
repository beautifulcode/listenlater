class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @series = @category.series
  end

  def index
    @categories = Category.ordered.includes(:subscriptions)
  end
end

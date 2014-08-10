class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @subscriptions = @category.subscriptions
  end

  def index
    @categories = Category.ordered.includes(:subscriptions)
  end
end

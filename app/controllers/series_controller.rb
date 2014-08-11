class SeriesController < ApplicationController

  def recent
    index
  end

  def popular
    index
  end

  def new
   @series = Series.new
  end

  def create
    @series = Series.new(params[:series])
    @series.save!
    respond_with @series
  end

  def index
    @series = Series.ordered
    respond_with @series
  end

  def show
    @series = Series.find(params[:id])
    respond_with @series
  end

end

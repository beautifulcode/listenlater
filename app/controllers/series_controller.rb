class SeriesController < ApplicationController
  respond_to :json, :html

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
    @subscription = @series.subscriptions.create(:user => current_user).save if current_user
    respond_with @series
  end

  def index
    @series = Series.ordered.paginate({page: params[:page] || 1, per_page: params[:per_page] || 50})
    respond_with @series
  end

  def show
    @series = Series.find(params[:id], include: :sources)
    @sources = @series.sources.paginate({page: params[:page] || 1, per_page: params[:per_page] || 50})
    respond_with @series
  end

end

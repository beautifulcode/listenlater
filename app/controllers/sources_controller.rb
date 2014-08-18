class SourcesController < ApplicationController

  respond_to :json, :html

  def recent
    collection = current_user ? current_user.sources : Source
    @sources = collection.recent.ordered.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_with @sources
  end

  def popular
    collection = current_user ? current_user.sources : Source
    @sources = collection.popular.ordered.includes(:subscription).paginate(:page => params[:page] || 1, :per_page => 20)
    respond_with @sources
  end

  def suggested
    @sources = current_user.suggested_sources.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_with @sources
  end

  def index
    @series = Series.find(params[:series_id]) if params[:series_id].present?
    @subscription = Subscription.find(params[:subscription_id]) if params[:subscription_id].present?
    collection = @subscription.sources if @subscription
    collection ||= @series.sources if @series
    collection ||= Source
    collection = collection.where(state: params[:filter]) if params[:filter]
    @sources = collection.includes(:subscription).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 20)
    respond_with @sources
  end

  def show
    @source = Source.find(params[:id])
    source_base = Series.find(params[:series_id]).sources if params[:series_id]
    source_base ||= current_user.try(:sources) || Source
    @sources = source_base
                     .ordered
                     .paginate(:page => page, :per_page => per_page)
    respond_with @source
  end

  def new
    @source = Source.new
  end

  def create
    if current_user
      @source = current_user.sources.find_or_create_by_title_and_url(params[:source][:title],  params[:source][:url])
    else
      @source = Source.find_or_create_by_title_and_url(params[:source][:title],  params[:source][:url])
    end

    if params[:subscription].present?
      if subscription = Subscription.find(params[:subscription_id])
        @source.subscription = subscription
        @source.user = subscription.user
      end
    end
    @source.save!
    respond_with @source
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      redirect_to @source
    else
      render :template => 'new'
    end
  end

end

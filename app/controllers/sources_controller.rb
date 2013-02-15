class SourcesController < ApplicationController

  respond_to :json, :html

  def recent
    @sources = current_user.recent_sources.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_with @sources
  end

  def popular
    @sources = Source.popular.ordered.includes(:subscription)
    respond_with @sources
  end

  def suggested
    @sources = current_user.suggested_sources.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_with @sources
  end

  def index
    @subscription = Subscription.find(params[:subscription_id]) if params[:subscription_id]
    @sources = @subscription.sources if @subscription
    @sources ||= Source.all.includes(:subscription)
    respond_with @sources
  end

  def show
    @source = Source.find(params[:id])
    @sources = current_user.sources if current_user 
    @sources ||= Source.recent
    respond_with @source
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(params[:source].except(:subscription_id))
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

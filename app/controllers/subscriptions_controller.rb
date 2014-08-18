class SubscriptionsController < ApplicationController
  respond_to :json, :html

  def recent
    index
  end

  def popular
    index
  end

  def new
   @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new
    @subscription.series = Series.find(params[:series_id]) if params[:series_id].present?
    @subscription.series = Series.create(title: params[:title], url: params[:url]) if params[:url].present?
    @subscription.user = current_user
    @subscription.save!
    respond_with @subscription
  end

  def index
    @subscriptions = Subscription.all.includes(:series)
    respond_with @subscriptions
  end

  def show
    @subscription = Subscription.find(params[:id])
    respond_with @subscription
  end


end

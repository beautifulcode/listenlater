class SubscriptionsController < ApplicationController
  respond_to :json, :html

  def new
   @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.save!
    respond_with @subscription
  end

  def index
    @subscriptions = Subscription.all
    respond_with @subscriptions
  end

  def show
    @subscription = Subscription.find(params[:id])
    respond_with @subscription
  end


end

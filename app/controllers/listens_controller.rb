class ListensController < ApplicationController
  respond_to :json
  def create
    @listen = Listen.new(params[:listen])
    @listen.source = Source.find(params[:listen][:source_id]) if params[:listen][:source_id]
    @listen.user = User.find(params[:listen][:user_id]) if params[:listen][:user_id]
    @listen.save
    respond_with @listen
  end
end

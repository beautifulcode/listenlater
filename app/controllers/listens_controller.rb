class ListensController < ApplicationController
  respond_to :json
  def create
    @listen = Listen.new(params[:listen])
    @listen.save
    respond_with @listen
  end
end

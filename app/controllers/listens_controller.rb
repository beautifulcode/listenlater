class ListensController < ApplicationController
  respond_to :json
  def create
    @listen = Listen.create(params[:listen])
    respond_with @listen
  end
end

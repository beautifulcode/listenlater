class SourcesController < ApplicationController
  respond_to :json, :html

  def recent
   index 
  end

  def popular
   index 
  end

  def suggested
   index 
  end

  def new
    
  end

  def create
    @source = Source.new(params[:source])
    @source.save!
    respond_with @source
  end

  def index
    @sources = Source.all
    respond_with @sources
  end

  def show
    @source = Source.find(params[:id])
    @sources = current_user.sources || Source.recent
    respond_with @source
  end

end

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
    @source = Source.new
  end

  def create
    @source = Source.new(params[:source])
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

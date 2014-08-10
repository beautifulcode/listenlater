class TagsController < ApplicationController

  def show
    @sources = Source.tagged_with(params[:id])
                      .ordered.paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 50)
  end

  def index
    @tags = [Source.tag_counts_on(:tags) + Subscription.tag_counts_on(:tags)].flatten.uniq
  end

end

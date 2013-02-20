class PagesController < ApplicationController

  def home
    render :text => params['hub.challenge'] if params['hub.challenge'] and return
    if current_user
      @sources = current_user.sources.recent.ordered.paginate(:page => 1, :per_page => 20)
      tmpl = 'pages/welcome' if current_user.first_visit? 
      tmpl ||= 'pages/suggestions' if current_user.has_no_sources?
      tmpl ||= 'users/home'
      render tmpl
    else
      @sources = Source.recent.ordered.paginate(:page => 1, :per_page => 20)
      render 'pages/home', :layout => 'home'
    end
  end

  def recent
   @sources = Source.recent.ordered
  end

  def popular
   @sources = Source.popular.ordered
  end

  def suggested
   @sources = Source.suggested.ordered
  end

end

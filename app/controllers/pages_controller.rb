class PagesController < ApplicationController

  def home
    render :text => params['hub.challenge'] if params['hub.challenge'] and return
    if current_user
      @sources = current_user.sources.recent
      tmpl = 'pages/welcome' if current_user.first_visit? 
      tmpl ||= 'pages/suggestions' if current_user.has_no_sources?
      tmpl ||= 'users/home'
      render tmpl
    else
      @sources = Source.recent
      render 'pages/home', :layout => 'home'
    end
  end

  def recent
   @sources = Source.recent
  end

  def popular
   @sources = Source.popular
  end

  def suggested
   @sources = Source.suggested
  end

end

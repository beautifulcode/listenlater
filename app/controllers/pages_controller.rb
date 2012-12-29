class PagesController < ApplicationController

  def home
    if current_user
      @sources = current_user.sources.recent
      tmpl = 'pages/welcome' if current_user.first_visit? 
      tmpl ||= 'pages/suggestions' if current_user.has_no_sources?
      tmpl ||= 'users/home'
      render tmpl
    else
      render 'pages/home'
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

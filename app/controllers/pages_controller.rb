class PagesController < ApplicationController

  def home
    if current_user
      tmpl = 'pages/welcome' if current_user.first_visit? 
      tmpl ||= 'pages/suggestions' if current_user.has_no_sources?
      tmpl ||= 'users/show'
      render tmpl
    else
      render 'pages/home'
    end
  end

end

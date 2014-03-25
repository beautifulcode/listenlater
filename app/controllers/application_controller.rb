class ApplicationController < ActionController::Base
  protect_from_forgery
  has_mobile_fu

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || welcome_or_home
  end

  def welcome_or_home
    previously_logged_in ? root_path : welcome_path
  end

  def previously_logged_in
    current_user.last_sign_in_at < current_user.current_sign_in_at
  end



  #def after_sign_in_path_for(resource)
    #sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    #if request.referer == sign_in_url
      #super
    #else
      #stored_location_for(resource) || request.referer || root_path
    #end
  #end

  def page
    params[:page].present? ? params[:page].to_i : 1
  end

  def per_page
    params[:per_page].present? ? params[:per_page].to_i : 20
  end
end

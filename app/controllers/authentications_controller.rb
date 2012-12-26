class AuthenticationsController < ApplicationController

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    if previously_logged_in?
      redirect_to '/'
    else
      redirect to '/welcome'
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end

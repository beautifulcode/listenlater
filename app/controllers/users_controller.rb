class UsersController < ApplicationController
  respond_to :js, :json, :html

  before_filter :authenticate_user!, :only => [:edit, :update, :destroy, :disconnect_omniauth_provider]

  def bookmarklet
    render :layout => false
  end

  def welcome
  end

  def show
    @user = User.find(params[:id])
    @subscriptions = @user.subscriptions
  end

  def disconnect_omniauth_provider
    provider = params[:provider]
    if Devise.omniauth_providers.include? provider.to_sym
      current_user.update_attribute("#{provider}_id", nil)
      current_user.save

      flash[:success] = "Your account has been disconnected from #{provider.titleize}."
    end
    redirect_to edit_user_registration_path
  end

end

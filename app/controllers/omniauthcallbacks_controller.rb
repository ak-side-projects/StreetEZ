class OmniauthcallbacksController < ApplicationController
  
  def create
    @user = User.find_by_auth_hash(request.env['omniauth.auth'])
    
    if @user
      sign_in!(@user)
      redirect_to root_url
    else
      if signed_in?
        @user = current_user
        @user.update_with_auth_hash(request.env['omniauth.auth'])
        redirect_to root_url
      else
        @user = User.create_by_auth_hash(request.env['omniauth.auth'])
        sign_in!(@user)
        redirect_to root_url
      end
    end
  end
  
end

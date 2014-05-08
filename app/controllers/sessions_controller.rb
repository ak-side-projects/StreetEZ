class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
   end

   def create
     @user = User.find_by_credentials(
       params[:user][:email],
       params[:user][:password]
      )

     if @user
       if @user.is_confirmed?
         sign_in!(@user)
         redirect_to root_url
       else
         confirmation_code = rand(10 ** 6).to_s
         @user.update(text_confirmation_code: confirmation_code)
         send_text(@user.mobile_number, "Please enter the following code on the page: #{confirmation_code}.")
         render "twilio/confirm_code"
       end
     else
       flash.now[:errors] = ["Please enter a valid email address and password."]
       @user = User.new
       render :new
     end
   end

   def destroy
     sign_out!
     redirect_to new_session_url
   end

end

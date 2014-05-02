class TwilioController < ApplicationController
  
  def outbound
    @user = User.find(user_params[:id])
    
    if @user.text_confirmation_code == user_params[:text_confirmation_code]
      @user.is_confirmed = true
      sign_in!(@user)
      redirect_to :root
    else
      confirmation_code = rand(10 ** 6).to_s
      @user.update(text_confirmation_code: confirmation_code)
      send_text(@user.mobile_number, "Please enter the following code on the page: #{confirmation_code}.")
      flash.now[:errors] = ["That code did not match. Please try again."]
      render :confirm_code
    end
  end
  
  def user_params
    params.require(:user).permit(:id, :text_confirmation_code)
  end
  
end
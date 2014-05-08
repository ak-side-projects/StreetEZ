class TwilioController < ApplicationController
  
  def outbound
    @user = User.find(user_params[:id])

    check_if_from_facebook
    
    if @user.mobile_number.present?
      if user_params[:text_confirmation_code].present?
        if @user.text_confirmation_code == user_params[:text_confirmation_code]
          confirm_and_sign_in!
          redirect_to :root
        else
          generate_confirmation_code
          flash.now[:errors] = ["That code did not match. Please try again."]
          render :confirm_code
        end
      else
        generate_confirmation_code
        render :confirm_code
      end
    else
      flash.now[:errors] = ["We need your mobile number to confirm that you are human."]
      flash.now[:errors] << ["Please enter a valid 10 digit phone number."]
      render :enter_mobile_number
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:id, :text_confirmation_code, :mobile_number)
  end
  
  def generate_confirmation_code
    confirmation_code = rand(10 ** 6).to_s
    @user.update(text_confirmation_code: confirmation_code)
    send_text(@user.mobile_number, "Please enter the following code on the page: #{confirmation_code}.")
  end
  
  def check_if_from_facebook
    if user_params[:mobile_number].present?
      mobile_number = user_params[:mobile_number].gsub(/\D/,"")
      if mobile_number.length == 10
        @user.update(mobile_number: user_params[:mobile_number])
      end
    end
  end
  
  def confirm_and_sign_in!
    @user.is_confirmed = true
    sign_in!(@user)
    send_text(@user.mobile_number, "Thanks for signing up with StreetEZ! We are very excited to help you with your apartment search.")
  end
  
end
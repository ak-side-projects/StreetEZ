class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    mobile_number = user_params[:mobile_number].gsub(/\D/,"")
    if mobile_number.length == 10
      @user = User.new(user_params)
      if @user.save
        confirmation_code = rand(10 ** 6).to_s
        @user.update(text_confirmation_code: confirmation_code)
        send_text(@user.mobile_number, "Please enter the following code on the page: #{confirmation_code}.")
        render "twilio/confirm_code"
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    else
      @user = User.new
      flash.now[:errors] = ["Please enter a valid 10 digit phone number."]
      render :new
    end
  end

  def show
    @user = current_user
        
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :mobile_number, :password)
  end
end

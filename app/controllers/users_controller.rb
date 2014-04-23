class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(
      :hosted_open_houses, 
      :open_houses, 
      :owned_rentals, 
      :saved_rentals
    ).find(current_user.id)
        
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end

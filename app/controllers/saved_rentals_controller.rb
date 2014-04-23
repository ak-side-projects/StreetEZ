class SavedRentalsController < ApplicationController

  def create
    current_user.saves.create(saved_rental_params)
    redirect_to user_url(current_user.id)
  end

  def destroy
    if params[:saved_rental]
      rental_id = params[:saved_rental][:rental_id]
    else
      rental_id = params[:id]
    end
    user_id = current_user.id
    SavedRental.find_by(user_id: user_id, rental_id: rental_id).destroy
    redirect_to user_url(current_user.id)
  end

  def saved_rental_params
    params.require(:saved_rental).permit(:rental_id)
  end

end

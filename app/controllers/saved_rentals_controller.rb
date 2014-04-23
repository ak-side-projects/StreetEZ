class SavedRentalsController < ApplicationController

  def create
    current_user.saves.create(saved_rental_params)
    
    back = request.env["HTTP_REFERER"]
    redirect_to back
  end

  def destroy
    if params[:saved_rental]
      rental_id = params[:saved_rental][:rental_id]
    else
      rental_id = params[:id]
    end
    user_id = current_user.id
    SavedRental.find_by(user_id: user_id, rental_id: rental_id).destroy
    
    back = request.env["HTTP_REFERER"]
    redirect_to back
  end

  def saved_rental_params
    params.require(:saved_rental).permit(:rental_id)
  end

end

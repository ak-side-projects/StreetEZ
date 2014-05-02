class SavedRentalsController < ApplicationController

  def create
    @saved_rental = current_user.saves.create(saved_rental_params)
    
    if request.xhr?
      render json: @saved_rental
    else
      back = request.env["HTTP_REFERER"]
      redirect_to back
    end
  end

  def destroy
    if params[:saved_rental]
      rental_id = params[:saved_rental][:rental_id]
    else
      rental_id = params[:id]
    end
    user_id = current_user.id
    @saved_rental = SavedRental.find_by(user_id: user_id, rental_id: rental_id)
    @saved_rental.active = false
    @saved_rental.destroy
    
    if request.xhr?
      render json: @saved_rental
    else
      back = request.env["HTTP_REFERER"]
      redirect_to back
    end
  end

  def saved_rental_params
    params.require(:saved_rental).permit(:rental_id)
  end

end

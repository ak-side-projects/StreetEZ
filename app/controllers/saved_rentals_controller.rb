class SavedRentalsController < ApplicationController

  def create
    current_user.saves.create(saved_rental_params)
    redirect_to user_url(current_user.id)
  end

  def destroy
    @saved_rental = SavedRental.find_by(id: params[:id])
    @saved_rental.destroy
    redirect_to user_url(current_user.id)
  end

  def saved_rental_params
    params.require(:saved_rental).permit(:rental_id)
  end

end

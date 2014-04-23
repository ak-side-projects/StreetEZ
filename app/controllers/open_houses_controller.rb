class OpenHousesController < ApplicationController
  
  def create
    @open_house = OpenHouse.new(open_house_params)
    @rental = Rental.find(open_house_params[:rental_id])
    if @open_house.save
      redirect_to rental_url(@rental)
    else
      flash[:errors] = @open_house.errors.full_messages
      back = request.env["HTTP_REFERER"]
      redirect_to back
    end
  end
  
  def update
    
  end
  
  def destroy
    @open_house = OpenHouse.find(params[:id])
    @open_house.update(active: false)
    @open_house.attend_open_houses.destroy_all
    
    back = request.env["HTTP_REFERER"]
    redirect_to back
  end
  
  private
  def open_house_params
    params.require(:open_house).permit(:rental_id, :event_datetime)
  end
  
end

class AttendOpenHousesController < ApplicationController
  
  def create
    @attend_open_house = AttendOpenHouse.new(
      open_house_id: params[:open_house_id], user_id: current_user.id
    )
    
    if @attend_open_house.save
      back = request.env["HTTP_REFERER"]
      redirect_to back
    else
      flash[:errors] = @attend_open_house.errors.full_messages
      back = request.env["HTTP_REFERER"]
      redirect_to back
    end
  end
  
  def destroy
    user_id = current_user.id
    open_house_id = params[:open_house_id]
    @attend_open_house = AttendOpenHouse.find_by(
      user_id: user_id, open_house_id: open_house_id
    ).destroy
    
    back = request.env["HTTP_REFERER"]
    redirect_to back
  end
  
end

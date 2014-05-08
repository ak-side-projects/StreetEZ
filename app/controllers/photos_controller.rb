class PhotosController < ApplicationController

  def destroy
    Photo.find(params[:id]).destroy
    back = request.env["HTTP_REFERER"]
    redirect_to back || user_url(current_user.id)
  end

end

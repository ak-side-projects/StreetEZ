class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.order(:is_read).order(created_at: :desc)
    render :index
  end
  
  def show
    notification = current_user.notifications.find(params[:id])
    notification.update(is_read: true)
    redirect_to notification.url
  end
  
end

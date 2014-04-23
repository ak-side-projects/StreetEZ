class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.order(updated_at: :desc)
    render :index
  end
  
end

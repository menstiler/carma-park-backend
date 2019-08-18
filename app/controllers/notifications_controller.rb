class NotificationsController < ApplicationController

  def index
    notifications = Notification.all
    render json: notifications
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
  end

end

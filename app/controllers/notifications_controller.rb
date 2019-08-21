class NotificationsController < ApplicationController

  def index
    notifications = Notification.all
    render json: notifications
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    render json: notification
  end

  def remove_all
    Notification.where(user_id: params[:user_id]).destroy_all
  end

end

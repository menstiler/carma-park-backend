class NotificationsController < ApplicationController

  def index
    notifications = Notification.all
    render json: notifications
  end

  def destroy
    notification = Notification.find(params[:id])
    ActionCable.server.broadcast 'notifications_channel', {delete: true, notification: notification}
    notification.destroy
  end

  def remove_all
    ActionCable.server.broadcast 'notifications_channel', {delete_all: true, user: params[:user_id]}
    Notification.where(user_id: params[:user_id]).destroy_all
  end

end

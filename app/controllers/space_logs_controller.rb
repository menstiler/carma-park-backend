class SpaceLogsController < ApplicationController

  def index
    space_logs = SpaceLog.all
    render json: space_logs
  end
  
  def destroy 
    space_log = SpaceLog.find(params[:id])
    user = User.find(space_log.user_id)
    space_log.destroy
    ActionCable.server.broadcast 'users_channel', {action: 'update', user: user.user_serialized}
  end 

  def destory_all 
    space_logs = SpaceLog.where(user_id: params[:id])
    space_logs.destory_all
  end 
end

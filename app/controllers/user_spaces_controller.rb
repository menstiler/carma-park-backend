class UserSpacesController < ApplicationController

  def index
    user_spaces = UserSpace.all
    render json: user_spaces
  end
  
  def destroy 
    user_space = UserSpace.find(params[:id])
    user_space.destroy
  end 

  def destory_all 
    user_spaces = UserSpace.where(user_id: params[:id])
    user_spaces.destory_all
  end 
end

class UserSpacesController < ApplicationController

  def index
    user_spaces = UserSpace.all
    render json: user_spaces
  end

  def claim
    user_space = UserSpace.create(user_id: params[:user_id], space_id: params[:space_id])
    space = Space.find(params[:space_id])
    space.update(claimed: true, claimer: user_space.user_id)
    render json: space
  end

  def cancel_claim
    user_space = UserSpace.where(user_id: params[:user_id], space_id: params[:space_id]).destroy_all
    space = Space.find(params[:space_id])
    space.update(claimed: false, claimer: nil)
    render json: space
  end

  def parked
    space = Space.find(params[:space_id])
    space.update(owner: params[:user_id])
    render json: space
  end

  def add_space_after_park
    space = Space.find(params[:space_id])
    space.update(claimed: false, claimer: nil)
    render json: space
  end

  def remove_space
    space = Space.find(params[:space_id])
    space.update(available: false)
    render json: space
  end

end

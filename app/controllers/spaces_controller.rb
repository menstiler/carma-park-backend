class SpacesController < ApplicationController

  def index
    spaces = Space.all
    render json: spaces
  end

  def show
    space = Space.find(params[:id])
    render json: space
  end

  def create
    space = Space.create(space_params)
    if (params[:space][:deadline][:minutes] != 0 || params[:space][:deadline][:hours] != 0)
      minutes = params[:space][:deadline][:minutes].to_i * 60
      hours = params[:space][:deadline][:hours].to_i * 3600
      time_to_add = hours + minutes
      new_time = space.created_at + time_to_add
      milliseconds_since = new_time.to_f * 1000
      space.update(deadline: milliseconds_since)
    end
    space.update(available: true)
    render json: space
  end

  def destroy
    space = Space.find(params[:id])
    space.destroy
  end

  def update
    space = Space.find(params[:id])
    space.update(address: params[:address])
    updated_space = space
    render json: updated_space
  end

  private

  def space_params
    params.require(:space).permit(:longitude, :latitude, :address, :owner, :deadline)
  end
end

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
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #   SpaceSerializer.new(space)
    # ).serializable_hash
    ActionCable.server.broadcast 'spaces_channel', {action: 'create', space: space}
    head :ok
    # render json: space
  end

  def claim
    user_space = UserSpace.create(user_id: params[:user_id], space_id: params[:space_id])
    space = Space.find(params[:space_id])
    space.update(claimed: true, claimer: user_space.user_id)
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space}
    head :ok
    # render json: space
  end

  def cancel_claim
    user_space = UserSpace.where(user_id: params[:user_id], space_id: params[:space_id]).destroy_all
    space = Space.find(params[:space_id])
    space.update(claimed: false, claimer: nil)
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space}
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
    head :ok
  end

  def remove_space
    space = Space.find(params[:space_id])
    space.update(available: false)
    ActionCable.server.broadcast 'spaces_channel', {action: 'delete', space: space}
    head :ok
  end

  def parked
    space = Space.find(params[:space_id])
    space.update(owner: params[:user_id])
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space}
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
    head :ok
  end

  def add_space_after_park
    space = Space.find(params[:space_id])
    space.update(claimed: false, claimer: nil)
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space}
    head :ok
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

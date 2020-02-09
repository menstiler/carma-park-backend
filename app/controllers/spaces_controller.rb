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
    user_space = UserSpace.create(user_id: space.owner, space_id: space.id, status: "created")
    note = Notification.create(user_id: space.owner, message: "Successfully created parking spot at #{space.address}")
    ActionCable.server.broadcast 'notifications_channel', note
    ActionCable.server.broadcast 'spaces_channel', {action: 'create', space: space}
    head :ok
  end

  def claim
    space = Space.find(params[:space_id])
    claimer = User.find(params[:user_id])
    space.update(claimed: true, claimer: params[:user_id], deadline: nil, available: false)
    note1 = Notification.create(user_id: space.owner, message: "#{claimer.name} has claimed the spot at #{space.address}")
    note2 = Notification.create(user_id: space.claimer, message: "Successfully claimed parking spot at #{space.address}")
    ActionCable.server.broadcast 'notifications_channel', note1
    ActionCable.server.broadcast 'notifications_channel', note2
    user_space_exist = user_space(params[:user_id], params[:space_id])
    if user_space_exist
      user_space_string = update_user_space(user_space_exist, "claimed")
      ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space, user_space: user_space_string}
    else 
      user_space = UserSpace.create(user_id: params[:user_id], space_id: params[:space_id], status: "claimed")
      user_space_string = UserSpaceSerializer.new(user_space)
      ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space, user_space: user_space_string}
    end
    head :ok
  end

  def cancel_claim
    user_space = UserSpace.where(user_id: params[:user_id], space_id: params[:space_id]).last
    user_space.update(status: "canceled")
    space = Space.find(params[:space_id])
    claimer = User.find(space.claimer)
    note1 = Notification.create(user_id: space.owner, message: "#{claimer.name} has canceled his claim")
    note2 = Notification.create(user_id: claimer.id, message: "Successfully canceled claim on parking spot at #{space.address}")
    space.update(claimed: false, claimer: nil, available: true)
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    user_space_string = UserSpaceSerializer.new(user_space)
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space, user_space: user_space}
    ActionCable.server.broadcast 'notifications_channel', note1
    ActionCable.server.broadcast 'notifications_channel', note2
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
    head :ok
  end

  def remove_space
    space = Space.find(params[:space_id])
    space.update(available: false)
    user_space = user_space(space.owner, space.id)
    update_user_space(user_space, "created")
    note = Notification.create(user_id: space.owner, message: "Successfully canceled parking spot")
    ActionCable.server.broadcast 'notifications_channel', note
    ActionCable.server.broadcast 'spaces_channel', {action: 'delete', space: space, user_space: user_space}
    head :ok
  end

  def parked
    space = Space.find(params[:space_id])
    original_owner = User.find(space.owner)
    claimer = User.find(space.claimer)
    note = Notification.create(user_id: original_owner.id, message: "#{claimer.name} has parked")
    note = Notification.create(user_id: claimer.id, message: "You have parked at #{space.address}")
    space.update(owner: params[:user_id])
    user_space = user_space(space.owner, space.id)
    update_user_space(user_space, "parked")
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    ActionCable.server.broadcast 'notifications_channel', note
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space, user_space: user_space}
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
    head :ok
  end

  def add_space_after_park
    space = Space.find(params[:space_id])
    space.update(claimed: false, claimer: nil, available: true)
    user_space = user_space(space.owner, space.id)
    update_user_space(user_space, "created")
    note = Notification.create(user_id: space.owner, message: "Successfully created parking spot at #{space.address}")
    ActionCable.server.broadcast 'notifications_channel', note
    ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space, user_space: user_space}
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

  def user_space(user_id, space_id)
    UserSpace.where(user_id: user_id, space_id: space_id).last
  end 

  def update_user_space(user_space, status)
    user_space.update(status: status)
    user_space_string = UserSpaceSerializer.new(user_space)
  end 

  def space_params
    params.require(:space).permit(:longitude, :latitude, :address, :owner, :deadline, :image)
  end
end

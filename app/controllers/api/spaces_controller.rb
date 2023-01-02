class Api::SpacesController < ApplicationController

  def index
    spaces = Space.all
    render json: spaces
  end

  def show
    space = Space.find(params[:id])
    render json: space
  end

  def create
    space = Space.find_by(address: params[:space][:address])
    if space
      if space.owner_id == space.claimer_id
        space.update(claimer_id: nil, claimed: false)
        ActionCable.server.broadcast 'users_channel', {action: 'update', user: space.owner.user_serialized}
        ActionCable.server.broadcast 'spaces_channel', {action: 'update', space: space.space_serialized}
      end
    else 
      space = Space.create(space_params)
      if (params[:space][:deadline][:minutes] != 0 || params[:space][:deadline][:hours] != 0)
        minutes = params[:space][:deadline][:minutes].to_i * 60
        hours = params[:space][:deadline][:hours].to_i * 3600
        time_to_add = hours + minutes
        new_time = space.created_at + time_to_add
        milliseconds_since = new_time.to_f * 1000
        space.update(deadline: milliseconds_since)
      end
      owner = User.find(space.owner_id)
      ActionCable.server.broadcast 'users_channel', {action: 'create', user: owner.user_serialized}
      ActionCable.server.broadcast 'spaces_channel', {action: 'create', space: space.space_serialized}
    end
    space_log = SpaceLog.create(user_id: space.owner_id, space_id: space.id, space: space, status: "created")
    note = Notification.create(user_id: space.owner_id, message: "Successfully created parking spot at #{space.address}")
    ActionCable.server.broadcast 'notifications_channel', note
    head :ok
  end

  def claim
    space = Space.find(params[:space_id])
    claimer = User.find(params[:user_id])
    space.update(claimed: true, claimer_id: params[:user_id], deadline: nil)
    note1 = Notification.create(user_id: space.owner_id, message: "#{claimer.name} has claimed the spot at #{space.address}")
    note2 = Notification.create(user_id: space.claimer_id, message: "Successfully claimed parking spot at #{space.address}")
    ActionCable.server.broadcast 'notifications_channel', note1
    ActionCable.server.broadcast 'notifications_channel', note2
    SpaceLog.create(user_id: params[:user_id], space_id: space.id, space: space, status: "claimed")
    ActionCable.server.broadcast 'users_channel', {action: 'update', user: claimer.user_serialized}
    ActionCable.server.broadcast 'spaces_channel', {action: 'claim', space: space.space_serialized}
    head :ok
  end

  def cancel_claim
    space = Space.find(params[:space_id])
    claimer = User.find(params[:user_id])
    space.update(claimed: false, claimer: nil)
    space_log = space_log(params[:user_id], params[:space_id])
    update_space_log(space_log, "canceled", space.id)
    note1 = Notification.create(user_id: space.owner_id, message: "#{claimer.name} has canceled his claim")
    note2 = Notification.create(user_id: claimer.id, message: "Successfully canceled claim on parking spot at #{space.address}")
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
    ActionCable.server.broadcast 'spaces_channel', {action: 'cancel', space: space.space_serialized}
    ActionCable.server.broadcast 'users_channel', {action: 'update', user: claimer.user_serialized}
    ActionCable.server.broadcast 'notifications_channel', note1
    ActionCable.server.broadcast 'notifications_channel', note2
    head :ok
  end

  def remove_space
    space = Space.find(params[:space_id])
    owner = User.find(space.owner_id)
    if space.claimed and space.claimer_id != space.owner_id
      render json: {error: "Cannot cancel space while it's claimed"}.to_json, :status => :bad_request
    else
      space.update(owner: nil, claimer: nil, claimed: false)
      note = Notification.create(user_id: space.owner_id, message: "Successfully canceled parking spot")
      ActionCable.server.broadcast 'notifications_channel', note
      ActionCable.server.broadcast 'users_channel', {action: 'update', user: owner.user_serialized}
      ActionCable.server.broadcast 'spaces_channel', {action: 'delete', space: space}
      head :ok
    end
  end

  def parked
    space = Space.find(params[:space_id])
    original_owner = User.find(space.owner_id)
    claimer = User.find(space.claimer_id)
    note1 = Notification.create(user_id: original_owner.id, message: "#{claimer.name} has parked")
    note2 = Notification.create(user_id: claimer.id, message: "You have parked at #{space.address}")
    space_log = space_log(space.claimer_id, space.id)
    update_space_log(space_log, "parked", space.id)
    space.update(owner_id: params[:user_id])
    chatroom = Chatroom.find_by(space: space.id)
    if chatroom
      chatroom.destroy
    end
    ActionCable.server.broadcast 'notifications_channel', note1
    ActionCable.server.broadcast 'notifications_channel', note2
    ActionCable.server.broadcast 'users_channel', {action: 'update', user: claimer.user_serialized}
    ActionCable.server.broadcast 'spaces_channel', {action: 'parked', space: space.space_serialized}
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'delete', chatroom: chatroom}
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

  def space_log(user_id, space_id)
    SpaceLog.where(user_id: user_id, space_id: space_id).last
  end 

  def update_space_log(space_log, status, space_id)
    space = Space.find(space_id)
    space_log.update(status: status, space: space)
    space_log_string = SpaceLogSerializer.new(space_log)
  end 

  def space_params
    params.require(:space).permit(:longitude, :latitude, :address, :owner_id, :deadline, :image)
  end
end

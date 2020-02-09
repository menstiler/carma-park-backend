class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      token = encode_token(user.id)
      ActionCable.server.broadcast 'users_channel', {action: 'create', user: user, token: token}
      # render json: {user: user, token: token}
    else
      ActionCable.server.broadcast 'users_channel', {errors: user.errors.full_messages}
      # render json: {errors: user.errors.full_messages}
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    Space.where(owner: user.id).destroy_all
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :username, :password, :image)
  end

end

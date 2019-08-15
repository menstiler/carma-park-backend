class UserSpacesController < ApplicationController

  def index
    user_spaces = UserSpace.all
    render json: user_spaces
  end

end

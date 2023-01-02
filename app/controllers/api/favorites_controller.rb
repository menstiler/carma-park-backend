class Api::FavoritesController < ApplicationController

  def add_favorites
    favorite = Favorite.create(favorite_params)
    render json: favorite
  end

  def remove_favorite
    favorite = Favorite.find(params[:id])
    favorite.destroy
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :name, :longitude, :latitude)
  end
end

class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :car_image, :json, default: {}
    add_column :users, :license_plate, :string
  end
end

class AddCarMakeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :car_make, :string
    add_column :users, :car_model, :string
  end
end

class AddAddressToSpace < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :address, :string
  end
end

class AddAddressToSpace < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :address, :string
  end
end

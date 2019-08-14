class AddOwnerToSpace < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :owner, :integer
  end
end

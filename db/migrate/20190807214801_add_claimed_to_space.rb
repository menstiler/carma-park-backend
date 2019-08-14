class AddClaimedToSpace < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :claimed, :boolean, default: false
  end
end

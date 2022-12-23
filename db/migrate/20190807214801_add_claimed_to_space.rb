class AddClaimedToSpace < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :claimed, :boolean, default: false
  end
end

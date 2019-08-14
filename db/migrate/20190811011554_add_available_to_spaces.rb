class AddAvailableToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :available, :boolean
  end
end

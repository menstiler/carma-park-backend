class AddAvailableToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :available, :boolean
  end
end

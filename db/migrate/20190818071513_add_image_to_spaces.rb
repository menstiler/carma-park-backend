class AddImageToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :image, :string
  end
end

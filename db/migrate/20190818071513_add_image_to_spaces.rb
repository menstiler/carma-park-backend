class AddImageToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :image, :string
  end
end

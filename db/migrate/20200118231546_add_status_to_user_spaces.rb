class AddStatusToUserSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :user_spaces, :status, :string
  end
end

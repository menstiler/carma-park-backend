class AddCreatorToChatrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :creator, :integer
  end
end

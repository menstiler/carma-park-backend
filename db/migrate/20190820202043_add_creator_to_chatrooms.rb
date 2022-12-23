class AddCreatorToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chatrooms, :creator, :integer
  end
end

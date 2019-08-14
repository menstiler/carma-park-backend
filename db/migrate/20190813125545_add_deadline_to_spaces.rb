class AddDeadlineToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :spaces, :deadline, :bigint
  end
end

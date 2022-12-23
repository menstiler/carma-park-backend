class AddDeadlineToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :deadline, :bigint
  end
end

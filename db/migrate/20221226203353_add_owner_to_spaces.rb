class AddOwnerToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :spaces, :owner, foreign_key: true
  end
end

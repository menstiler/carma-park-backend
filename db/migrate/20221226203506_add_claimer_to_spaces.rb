class AddClaimerToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :spaces, :claimer, null: true, foreign_key: true
  end
end

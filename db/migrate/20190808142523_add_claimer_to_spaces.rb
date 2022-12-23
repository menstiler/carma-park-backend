class AddClaimerToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :claimer, :integer
  end
end

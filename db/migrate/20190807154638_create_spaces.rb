class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end

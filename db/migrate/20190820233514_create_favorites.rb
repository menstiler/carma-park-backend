class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end

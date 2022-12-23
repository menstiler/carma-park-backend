class CreateUserSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :user_spaces do |t|
      t.references :user, foreign_key: true
      t.references :space, foreign_key: true

      t.timestamps
    end
  end
end

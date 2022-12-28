class CreateSpaceLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :space_logs do |t|
      t.string :status
      t.references :user, foreign_key: true
      t.integer :space_id
      t.json :space, default: {}
      t.timestamps
    end
  end
end

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end

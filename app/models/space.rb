class Space < ApplicationRecord
  has_many :user_spaces, dependent: :destroy
  has_many :users, through: :user_spaces
end

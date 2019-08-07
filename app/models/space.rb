class Space < ApplicationRecord
  has_many :user_spaces
  has_many :users, through: :user_spaces
end

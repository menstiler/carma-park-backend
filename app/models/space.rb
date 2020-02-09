class Space < ApplicationRecord
  attribute :available, :boolean, default: true
  has_many :user_spaces, dependent: :destroy
  has_many :users, through: :user_spaces

end

class Space < ApplicationRecord
  has_many :user_spaces, dependent: :destroy
  has_many :users, through: :user_spaces
  validates :address, uniqueness: true

  def space_serialized
    SpaceSerializer.new(self)
  end 
end

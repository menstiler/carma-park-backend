class Space < ApplicationRecord
  validates :address, uniqueness: true
  belongs_to :owner, optional: true, class_name: 'User', foreign_key: :owner_id
  belongs_to :claimer, optional: true, class_name: 'User', foreign_key: :claimer_id

  def space_serialized
    SpaceSerializer.new(self)
  end 
end

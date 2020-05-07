class Like < ApplicationRecord
  belongs_to :user
  belongs_to :gossip
  validates_presence_of :value, :user, :gossip
  validates :user_id, uniqueness: { scope: [:gossip_id] }
  validates :value, inclusion: 0..4
end
 
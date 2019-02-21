class Conversation < ActiveRecord::Base
  # associations
  belongs_to :user1, :foreign_key => :user1_id, class_name: 'User'
  belongs_to :user2, :foreign_key => :user2_id, class_name: 'User'

  # validations
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :user1_id, scope: :user2_id
  scope :between, ->(user1_id, user2_id) do
    where("(conversations.user1_id = ? AND conversations.user2_id =?) OR (conversations.user1_id = ? AND conversations.user2_id =?)", user1_id, user2_id, user2_id, user1_id)
  end
end

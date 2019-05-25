class ActionParticipation < ApplicationRecord
  # associations
  belongs_to :action
  belongs_to :user

  # validations
  validates :action, uniqueness: { scope: :user, message: "should not have users participate twice" }
end

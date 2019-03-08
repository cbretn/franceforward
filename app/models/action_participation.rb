class ActionParticipation < ApplicationRecord
  # associations
  belongs_to :action
  belongs_to :user

  # validations
  # TODO: validates uniqueness of action and user scoped
  validates :action, uniqueness: { scope: :user, message: "should not have users participate twice" }
end

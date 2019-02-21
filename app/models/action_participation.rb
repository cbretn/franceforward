class ActionParticipation < ApplicationRecord
  # associations
  belongs_to :action
  belongs_to :user

  # validations
  # TODO: validates uniqueness of action and user scoped
end

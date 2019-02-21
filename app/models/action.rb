class Action < ApplicationRecord
  # associations
  belongs_to :theme
  belongs_to :user

  # validations
  validates :title, presence: true
  validates :description, presence: true # minimum characters
  # check-in / check-out ?
end

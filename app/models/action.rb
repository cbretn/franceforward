class Action < ApplicationRecord
  # associations
  belongs_to :theme
  belongs_to :user
  has_many :action_participations, dependent: :destroy

  # validations
  validates :title, presence: true
  validates :description, presence: true # minimum characters
  # check-in / check-out ?
end

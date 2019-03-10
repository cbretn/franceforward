class Discussion < ApplicationRecord
  # associations
  belongs_to :theme
  belongs_to :user

  # validations
  validates :title, presence: true # , uniqueness: true ?
  validates :content, presence: true
end

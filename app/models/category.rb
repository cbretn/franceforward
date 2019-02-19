class Category < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # validations
  validates :name, presence: true, uniqueness: true

  # associations
  has_many :themes
  # has_one :description
  # has_many :discussions
  # has_many :actions
end

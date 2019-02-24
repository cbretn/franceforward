class Category < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # associations
  has_many :themes, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true
end

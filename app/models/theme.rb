class Theme < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # validations
  validates :name, presence: true, uniqueness: true

  # associations
  belongs_to :category
end

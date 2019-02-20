class Category < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # validations
  validates :name, presence: true, uniqueness: true

  # associations
  has_many :themes, dependent: :destroy
end

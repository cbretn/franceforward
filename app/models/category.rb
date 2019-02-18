class Category < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, uniqueness: true
  # has_many :themes
end

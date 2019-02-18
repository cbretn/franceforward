class Category < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  # has_many :themes
end

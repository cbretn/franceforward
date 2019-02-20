class Theme < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # validations
  validates :name, presence: true, uniqueness: true
  # validates :content, presence: true

  # associations
  belongs_to :category
  # has_one :description
  # has_many :discussions
  # has_many :actions
end

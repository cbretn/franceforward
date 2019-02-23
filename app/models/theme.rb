class Theme < ApplicationRecord
  # uploads
  mount_uploader :photo, PhotoUploader

  # associations
  belongs_to :category
  has_one :description, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :actions, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
end

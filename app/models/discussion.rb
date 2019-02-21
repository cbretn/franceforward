class Discussion < ApplicationRecord
  belongs_to :theme
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
end

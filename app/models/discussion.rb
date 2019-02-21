class Discussion < ApplicationRecord
  belongs_to :theme

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
end

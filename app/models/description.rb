class Description < ApplicationRecord
  # associations
  belongs_to :theme

  # validations
  validates :content, presence: true
end

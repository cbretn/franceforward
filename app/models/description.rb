class Description < ApplicationRecord
  belongs_to :theme

  validates :content, presence: true
end

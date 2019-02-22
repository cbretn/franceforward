class User < ApplicationRecord
  after_save :set_default_avatar
  # TODO: after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # uploads
  mount_uploader :photo, PhotoUploader

  # associations
  has_many :conversations, foreign_key: :user1_id, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :actions, dependent: :destroy

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :location, presence: true

  private

  def set_default_avatar
    default_picture = "https://res.cloudinary.com/cbretn/image/upload/v1550819988/default-picture.png"
    self.remote_photo_url = default_picture if photo.nil?
  end
end

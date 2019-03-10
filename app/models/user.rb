class User < ApplicationRecord
  after_save :set_default_avatar
  after_destroy :delete_conversations
  # TODO: after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # uploads
  mount_uploader :photo, PhotoUploader

  # associations
  # has_many :conversations, foreign_key: :user1_id, dependent: :destroy
  has_many :messages, foreign_key: :user_id, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :action_participations, dependent: :destroy

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :location, presence: true

  def conversations
    Conversation.where('user1_id = :id OR user2_id = :id', id: id)
  end

  private

  def set_default_avatar
    default_picture = "https://res.cloudinary.com/cbretn/image/upload/v1550819988/default-picture.png"
    self.remote_photo_url = default_picture if photo.file.nil?
  end

  def delete_conversations
    Conversation.where('user1_id = :id OR user2_id = :id', id: id).map(&:destroy)
  end
end

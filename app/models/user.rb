class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }
  has_many :messages
  has_one_attached :avatar

  after_commit :update_avatar, on: %i[create update]

  # Avatar thumbnail, used when creating or updating user
  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  # Chat avatar, used in chat bubbles
  def chat_avatar
    avatar.variant(resize_to_limit: [25, 25]).processed
  end

  private

  def update_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets',
                                    'images', 'default_avatar.png')),
      filename: 'default_avatar.png',
      content_type: 'image/png'
    )
  end
end

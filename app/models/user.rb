class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :sent_follow_requests, foreign_key: :sender_id, class_name: "FollowRequest", dependent: :destroy
  has_many :received_follow_requests, foreign_key: :receiver_id, class_name: "FollowRequest", dependent: :destroy
  has_many :pending_sent_requests, -> { where(follow_requests: { accepted: false }) }, through: :sent_follow_requests, source: :receiver
  has_many :following, -> { where(follow_requests: { accepted: true }) }, through: :sent_follow_requests, source: :receiver
  has_many :pending_received_requests, -> { where(follow_requests: { accepted: false }) }, through: :received_follow_requests, source: :sender
  has_many :followers, -> { where(follow_requests: { accepted: true }) }, through: :received_follow_requests, source: :sender

  has_many :comments, dependent: :destroy

  has_one_attached :profile_photo

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }
  validates :full_name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :bio, length: { maximum: 200 }

  def liked?(post)
    self.liked_posts.include?(post)
  end

  def follows?(user)
    self.following.include?(user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user |
      user.provider = auth.provider
      user.full_name = auth.info.name
      user.username = auth.info.nickname
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end

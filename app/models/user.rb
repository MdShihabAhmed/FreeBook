class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :profile_photo

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 3 }
  validates :full_name, presence: true, length: {minimum: 5, maximum: 50}
  validates :bio, length: { maximum: 200 }

  def liked?(post)
    self.liked_posts.include?(post)
  end
end

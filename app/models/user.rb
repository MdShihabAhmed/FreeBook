class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_one_attached :profile_photo

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :full_name, presence: true
end

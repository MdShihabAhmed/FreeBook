class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 4 }
  validates :body, presence: true, length: { minimum: 10 }
end

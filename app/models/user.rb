class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id', primary_key: 'id'
  has_many :likes, foreign_key: 'user_id'

  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  ROLES = %w[admin user].freeze

  # Set a default role when creating a user
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'user'
  end

  def admin?
    role == 'admin'
  end

  def recentposts
    posts.order(created_at: :desc).limit(3)
  end
end

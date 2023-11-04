class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :Title, presence: true, length: { maximum: 250 }
  validates :likes_count, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_count, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_counter

  def update_counter
    author.update(posts_count: author.posts.size)
  end

  def recent_comment
    comments.where(post_id: self[:id]).order(created_at: :desc).limit(5)
  end
end

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :updatepostcounter

  private

  def updatepostcounter
    post.update(likescounter: post.likes.count)
  end
end

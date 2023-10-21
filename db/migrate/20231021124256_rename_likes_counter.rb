class RenameLikesCounter < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :CommentsCounter, :comments_count
    rename_column :posts, :LikesCounter, :likes_count
  end
end

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))

    if @comment.save
      flash[:success] = 'Added a new comment!'
    else
      flash[:error] = 'Comment was not added'
    end

    redirect_to user_post_path(current_user, params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

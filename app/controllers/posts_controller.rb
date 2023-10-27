class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).includes(:comments, :user).paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
    @index = params[:index]
    @user = current_user
  end
end

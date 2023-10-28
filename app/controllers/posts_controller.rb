class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).includes(:comments, :author).paginate(page: params[:page], per_page: 10)
  end

  def show
    logger.debug(params)
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path(id: current_user.id)
    else
      flash.now[:alert] = 'Cannot create a new post'
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:Title, :text)
  end
end

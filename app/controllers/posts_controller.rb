class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
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

  def destroy
    @post = Post.find(params[:id])

    authorize! :destroy, @post
    @author = @post.user
    @author.decrement!(:posts_count)
    @post.destroy
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'post was successfully deleted.'
    else
      redirect_to redirect_url, alert: 'Failed to delete the post.'
    end
  end

  def post_params
    params.require(:post).permit(:Title, :text)
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.published
  end

  def new
    @user = current_user
    @post =Post.new
  end

  def create
    @user = current_user
    @user.posts.create(post_params)
    redirect_to index_path
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to "/",flash: {danger: "投稿を削除しました"}
    end
  end

  def confirm
    @post = current_user.posts.draft
  end

  private
  def post_params
    params.require(:post).permit(:body, :image, :status)
  end
end

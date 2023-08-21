class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  private
  def post_params
    params.require(:post).permit(:body, :image, :status, :title, :empathy)
  end
end

class Admin::UsersController < ApplicationController
  before_action :admin_user
  def index
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    redirect_to root_path
    end
  end

  private
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
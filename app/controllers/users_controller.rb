class UsersController < ApplicationController

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    log_in @user
    redirect_to posts_path
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    redirect_to root_path
    end
  end

  def mypage
    @posts = current_user.posts.published.order(created_at: :desc)
    @post_empathy = current_user.empathies.where.not(empathy: nil).includes(:post).order(created_at: :desc)
    @post_draft = current_user.posts.draft.order(created_at: :desc)
  end

  def empathy
    @post_happy = current_user.empathies.where(empathy: :happy).includes(:post).order(created_at: :desc)
    @post_sad = current_user.empathies.where(empathy: :sad).includes(:post).order(created_at: :desc)
    @post_love = current_user.empathies.where(empathy: :love).includes(:post).order(created_at: :desc)
    @post_anger = current_user.empathies.where(empathy: :anger).includes(:post).order(created_at: :desc)
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation, :name)
  end

  def user_update_params
    params.require(:user).permit(:email, :name)
  end

end


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
    redirect_to "/"
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_update_params)
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end
end


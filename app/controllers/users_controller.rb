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

  private
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end
end


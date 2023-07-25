class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "ログインできなかったよ"
      render 'new'
    end
  end

  def destroy
    log_out
    respond_to do |format|
      format.html { redirect_to root_url, notice: "ログアウトしたよ", status: :see_other }
      format.json { head :no_content }
    end
    
  end
end

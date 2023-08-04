class EmpathiesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    empathy = current_user.empathies.new(post_id: post.id)
    empathy.save
    redirect_to request.referer
  end

  def destroy
    post= Post.find(params[:post_id])
    empathy = current_user.empathies.find_by(post_id: post.id)
    empathy.destroy
    redirect_to request.referer
  end
end

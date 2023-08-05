class EmpathiesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    empathy_value = Empathy.empathies[params[:empathy]] || Empathy.empathies[:default]
    empathy = current_user.empathies.create(post_id: post.id, empathy: empathy_value)
    redirect_to request.referer
  end

  def destroy
    post= Post.find(params[:post_id])
    empathy = current_user.empathies.find_by(post_id: post.id)
    empathy.destroy
    redirect_to request.referer
  end
end

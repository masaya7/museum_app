class PostsController < ApplicationController
  def index
    @posts = Post.published.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])

  end

  def new
    @post =Post.new
  end

  def create
    @post = current_user.posts.new(new_post_params)
    if @post.save
      redirect_to index_path
    else
      @post = Post.new(new_post_params)
      flash.now[:danger] = "未入力があります。写真、題名、投稿内容すべて入力してください。下書きにするときも何か入れてください"
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集しました"
      redirect_to draft_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to mypage_users_path,flash: {danger: "投稿を削除しました"}
    end
  end

  def draft
    @post = current_user.posts.draft.order(created_at: :desc)
  end

  private
  def post_params
    params.require(:post).permit(:body, :image, :status, :title, :empathy)
  end

  def new_post_params
    params.require(:post).permit(:body, :image, :title,:status)
  end
end

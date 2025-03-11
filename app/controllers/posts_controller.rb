class PostsController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]
  before_action :resume_session, only: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(post_params)
    redirect_to @post
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully!"
    else
      render :edit, alert: "Could not update post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

class PostsController < ApplicationController
  before_action :check_user, only: %i[new create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render layout: 'panel'
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: t('post.new.success')
    else
      render :new, layout: 'panel'
    end
  end

  def edit
    @post = Post.find(params[:id])
    render layout: 'panel'
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: t('post.edit.success')
    else
      render :edit, layout: 'panel'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def check_user
    redirect_to root_path unless user_signed_in?
  end
end

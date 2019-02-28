class PostsController < ApplicationController
  before_action :check_user, only: %i[new create edit update]
  before_action :set_post, only: %i[show edit update]
  before_action :check_author, only: %i[edit update]

  def index
    @posts = Post.all
  end

  def show; end

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
    render layout: 'panel'
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('post.edit.success')
    else
      render :edit, layout: 'panel'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def check_user
    redirect_to root_path unless user_signed_in?
  end

  def check_author
    redirect_to root_path unless @post.author?(current_user)
  end
end

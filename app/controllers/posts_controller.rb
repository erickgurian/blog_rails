class PostsController < ApplicationController
  before_action :check_user, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :check_author, only: %i[edit update destroy]

  def index
    @posts = Post.all
    @categories = Category.all
  end

  def show; end

  def new
    @post = Post.new
    @categories = Category.all
    render layout: 'panel'
  end

  def create
    @post = current_user.posts.new(post_params)
    @category = Category.where(id: params[:category_ids])
    add_category(@post, @category)
    if @post.save
      redirect_to @post, notice: t('post.new.success')
    else
      render :new, layout: 'panel'
    end
  end

  def edit
    @categories = Category.all
    render layout: 'panel'
  end

  def update
    @category = Category.where(id: params[:category_ids])
    add_category(@post, @category)
    if @post.update(post_params)
      redirect_to @post, notice: t('post.edit.success')
    else
      render :edit, layout: 'panel'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    @param = params[:search]
    @posts = Post.where('title like ?', "%#{@param}%")
  end

  private

  def add_category(post, categories)
    return unless categories.none? && categories.nil?

    categories.each do |category|
      post.categories << category
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, category_ids: [])
  end

  def check_user
    redirect_to root_path unless user_signed_in?
  end

  def check_author
    redirect_to root_path unless @post.author?(current_user)
  end
end

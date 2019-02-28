class PostsController < ApplicationController
  before_action :check_user, only: %i[new create]

  def index; end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render layout: 'panel'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post criado com sucesso!'
    else
      render :new, layout: 'panel'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def check_user
    redirect_to root_path unless user_signed_in?
  end
end

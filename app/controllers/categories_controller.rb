class CategoriesController < ApplicationController
  layout 'panel'

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    render layout: 'application'
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: t('category.new.success')
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

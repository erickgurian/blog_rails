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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: t('category.edit.success')
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

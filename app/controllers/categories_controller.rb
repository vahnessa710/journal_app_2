class CategoriesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories
    @due_today = current_user.tasks.where(due_date: Date.today)
  end

  def show
    @tasks = @category.tasks
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash.alert = "New category successfully created."
      redirect_to categories_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash.alert = "Category has been updated successfully."
      redirect_to category_path
    else
      flash.alert = "Error in updating category."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash.alert = "Category has been deleted successfully."
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
  
end

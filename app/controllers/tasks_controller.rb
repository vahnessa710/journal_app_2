class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [:index]
  before_action :set_task, except: [:index, :new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    @tasks = current_user.tasks.includes(:category)
    @due_today = @tasks.where(due_date: Date.today)
  end

  def show;end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)
    if @task.save
      redirect_to category_path(@category), notice: 'Task is successfully created.'
    else
      flash.alert = 'Error in saving new task.'
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_task_path(@category, @task), notice: 'Task is successfully updated.'
    else
      flash.alert = "Error in updating category."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@category), notice: 'Task is successfully deleted.'
  end
  
  private
  
  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date)
  end
  
  def record_not_found
    redirect_to categories_path, alert: 'record does not exist'
  end
end
